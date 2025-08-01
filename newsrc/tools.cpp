/**
 * The Forgotten Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2017  Mark Samman <mark.samman@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#include "otpch.h"

#include "tools.h"
#include "configmanager.h"

extern ConfigManager g_config;

void printXMLError(const std::string& where, const std::string& fileName, const pugi::xml_parse_result& result)
{
	std::cout << '[' << where << "] Failed to load " << fileName << ": " << result.description() << std::endl;

	FILE* file = fopen(fileName.c_str(), "rb");
	if (!file) {
		return;
	}

	char buffer[32768];
	uint32_t currentLine = 1;
	std::string line;

	size_t offset = static_cast<size_t>(result.offset);
	size_t lineOffsetPosition = 0;
	size_t index = 0;
	size_t bytes;
	do {
		bytes = fread(buffer, 1, 32768, file);
		for (size_t i = 0; i < bytes; ++i) {
			char ch = buffer[i];
			if (ch == '\n') {
				if ((index + i) >= offset) {
					lineOffsetPosition = line.length() - ((index + i) - offset);
					bytes = 0;
					break;
				}
				++currentLine;
				line.clear();
			} else {
				line.push_back(ch);
			}
		}
		index += bytes;
	} while (bytes == 32768);
	fclose(file);

	std::cout << "Line " << currentLine << ':' << std::endl;
	std::cout << line << std::endl;
	for (size_t i = 0; i < lineOffsetPosition; i++) {
		if (line[i] == '\t') {
			std::cout << '\t';
		} else {
			std::cout << ' ';
		}
	}
	std::cout << '^' << std::endl;
}

static uint32_t circularShift(int bits, uint32_t value)
{
	return (value << bits) | (value >> (32 - bits));
}

static void processSHA1MessageBlock(const uint8_t* messageBlock, uint32_t* H)
{
	uint32_t W[80];
	for (int i = 0; i < 16; ++i) {
		const size_t offset = i << 2;
		W[i] = messageBlock[offset] << 24 | messageBlock[offset + 1] << 16 | messageBlock[offset + 2] << 8 | messageBlock[offset + 3];
	}

	for (int i = 16; i < 80; ++i) {
		W[i] = circularShift(1, W[i - 3] ^ W[i - 8] ^ W[i - 14] ^ W[i - 16]);
	}

	uint32_t A = H[0], B = H[1], C = H[2], D = H[3], E = H[4];

	for (int i = 0; i < 20; ++i) {
		const uint32_t tmp = circularShift(5, A) + ((B & C) | ((~B) & D)) + E + W[i] + 0x5A827999;
		E = D; D = C; C = circularShift(30, B); B = A; A = tmp;
	}

	for (int i = 20; i < 40; ++i) {
		const uint32_t tmp = circularShift(5, A) + (B ^ C ^ D) + E + W[i] + 0x6ED9EBA1;
		E = D; D = C; C = circularShift(30, B); B = A; A = tmp;
	}

	for (int i = 40; i < 60; ++i) {
		const uint32_t tmp = circularShift(5, A) + ((B & C) | (B & D) | (C & D)) + E + W[i] + 0x8F1BBCDC;
		E = D; D = C; C = circularShift(30, B); B = A; A = tmp;
	}

	for (int i = 60; i < 80; ++i) {
		const uint32_t tmp = circularShift(5, A) + (B ^ C ^ D) + E + W[i] + 0xCA62C1D6;
		E = D; D = C; C = circularShift(30, B); B = A; A = tmp;
	}

	H[0] += A;
	H[1] += B;
	H[2] += C;
	H[3] += D;
	H[4] += E;
}

std::string transformToSHA1(const std::string& input)
{
	uint32_t H[] = {
		0x67452301,
		0xEFCDAB89,
		0x98BADCFE,
		0x10325476,
		0xC3D2E1F0
	};

	uint8_t messageBlock[64];
	size_t index = 0;

	uint32_t length_low = 0;
	uint32_t length_high = 0;
	for (char ch : input) {
		messageBlock[index++] = ch;

		length_low += 8;
		if (length_low == 0) {
			length_high++;
		}

		if (index == 64) {
			processSHA1MessageBlock(messageBlock, H);
			index = 0;
		}
	}

	messageBlock[index++] = 0x80;

	if (index > 56) {
		while (index < 64) {
			messageBlock[index++] = 0;
		}

		processSHA1MessageBlock(messageBlock, H);
		index = 0;
	}

	while (index < 56) {
		messageBlock[index++] = 0;
	}

	messageBlock[56] = length_high >> 24;
	messageBlock[57] = length_high >> 16;
	messageBlock[58] = length_high >> 8;
	messageBlock[59] = length_high;

	messageBlock[60] = length_low >> 24;
	messageBlock[61] = length_low >> 16;
	messageBlock[62] = length_low >> 8;
	messageBlock[63] = length_low;

	processSHA1MessageBlock(messageBlock, H);

	char hexstring[41];
	static const char hexDigits[] = {"0123456789abcdef"};
	for (int hashByte = 20; --hashByte >= 0;) {
		const uint8_t byte = H[hashByte >> 2] >> (((3 - hashByte) & 3) << 3);
		index = hashByte << 1;
		hexstring[index] = hexDigits[byte >> 4];
		hexstring[index + 1] = hexDigits[byte & 15];
	}
	return std::string(hexstring, 40);
}

void replaceString(std::string& str, const std::string& sought, const std::string& replacement)
{
	size_t pos = 0;
	size_t start = 0;
	size_t soughtLen = sought.length();
	size_t replaceLen = replacement.length();

	while ((pos = str.find(sought, start)) != std::string::npos) {
		str = str.substr(0, pos) + replacement + str.substr(pos + soughtLen);
		start = pos + replaceLen;
	}
}

void trim_right(std::string& source, char t)
{
	source.erase(source.find_last_not_of(t) + 1);
}

void trim_left(std::string& source, char t)
{
	source.erase(0, source.find_first_not_of(t));
}

void toLowerCaseString(std::string& source)
{
	std::transform(source.begin(), source.end(), source.begin(), tolower);
}

std::string asLowerCaseString(std::string source)
{
	toLowerCaseString(source);
	return source;
}

std::string asUpperCaseString(std::string source)
{
	std::transform(source.begin(), source.end(), source.begin(), toupper);
	return source;
}

StringVector explodeString(const std::string& inString, const std::string& separator, int32_t limit/* = -1*/)
{
	StringVector returnVector;
	std::string::size_type start = 0, end = 0;

	while (--limit != -1 && (end = inString.find(separator, start)) != std::string::npos) {
		returnVector.push_back(inString.substr(start, end - start));
		start = end + separator.size();
	}

	returnVector.push_back(inString.substr(start));
	return returnVector;
}

IntegerVector vectorAtoi(const StringVector& stringVector)
{
	IntegerVector returnVector;
	for (const auto& string : stringVector) {
		returnVector.push_back(std::stoi(string));
	}
	return returnVector;
}

std::mt19937& getRandomGenerator()
{
	static std::random_device rd;
	static std::mt19937 generator(rd());
	return generator;
}

int32_t uniform_random(int32_t minNumber, int32_t maxNumber)
{
	static std::uniform_int_distribution<int32_t> uniformRand;
	if (minNumber == maxNumber) {
		return minNumber;
	} else if (minNumber > maxNumber) {
		std::swap(minNumber, maxNumber);
	}
	return uniformRand(getRandomGenerator(), std::uniform_int_distribution<int32_t>::param_type(minNumber, maxNumber));
}

int32_t normal_random(int32_t minNumber, int32_t maxNumber)
{
	static std::normal_distribution<float> normalRand(0.5f, 0.25f);
	if (minNumber == maxNumber) {
		return minNumber;
	} else if (minNumber > maxNumber) {
		std::swap(minNumber, maxNumber);
	}

	int32_t increment;
	const int32_t diff = maxNumber - minNumber;
	const float v = normalRand(getRandomGenerator());
	if (v < 0.0) {
		increment = diff / 2;
	} else if (v > 1.0) {
		increment = (diff + 1) / 2;
	} else {
		increment = round(v * diff);
	}
	return minNumber + increment;
}

bool boolean_random(double probability/* = 0.5*/)
{
	static std::bernoulli_distribution booleanRand;
	return booleanRand(getRandomGenerator(), std::bernoulli_distribution::param_type(probability));
}

void trimString(std::string& str)
{
	str.erase(str.find_last_not_of(' ') + 1);
	str.erase(0, str.find_first_not_of(' '));
}

std::string convertIPToString(uint32_t ip)
{
	char buffer[17];

	int res = sprintf(buffer, "%u.%u.%u.%u", ip & 0xFF, (ip >> 8) & 0xFF, (ip >> 16) & 0xFF, (ip >> 24));
	if (res < 0) {
		return {};
	}

	return buffer;
}

std::string formatDate(time_t time)
{
	const tm* tms = localtime(&time);
	if (!tms) {
		return {};
	}

	char buffer[20];
	int res = sprintf(buffer, "%02d/%02d/%04d %02d:%02d:%02d", tms->tm_mday, tms->tm_mon + 1, tms->tm_year + 1900, tms->tm_hour, tms->tm_min, tms->tm_sec);
	if (res < 0) {
		return {};
	}
	return {buffer, 19};
}

std::string formatDateShort(time_t time)
{
	const tm* tms = localtime(&time);
	if (!tms) {
		return {};
	}

	char buffer[12];
	size_t res = strftime(buffer, 12, "%d %b %Y", tms);
	if (res == 0) {
		return {};
	}
	return {buffer, 11};
}

Direction getDirection(const std::string& string)
{
	Direction direction = DIRECTION_NORTH;

	if (string == "north" || string == "n" || string == "0") {
		direction = DIRECTION_NORTH;
	} else if (string == "east" || string == "e" || string == "1") {
		direction = DIRECTION_EAST;
	} else if (string == "south" || string == "s" || string == "2") {
		direction = DIRECTION_SOUTH;
	} else if (string == "west" || string == "w" || string == "3") {
		direction = DIRECTION_WEST;
	} else if (string == "southwest" || string == "south west" || string == "south-west" || string == "sw" || string == "4") {
		direction = DIRECTION_SOUTHWEST;
	} else if (string == "southeast" || string == "south east" || string == "south-east" || string == "se" || string == "5") {
		direction = DIRECTION_SOUTHEAST;
	} else if (string == "northwest" || string == "north west" || string == "north-west" || string == "nw" || string == "6") {
		direction = DIRECTION_NORTHWEST;
	} else if (string == "northeast" || string == "north east" || string == "north-east" || string == "ne" || string == "7") {
		direction = DIRECTION_NORTHEAST;
	}

	return direction;
}

Position getNextPosition(Direction direction, Position pos)
{
	switch (direction) {
		case DIRECTION_NORTH:
			pos.y--;
			break;

		case DIRECTION_SOUTH:
			pos.y++;
			break;

		case DIRECTION_WEST:
			pos.x--;
			break;

		case DIRECTION_EAST:
			pos.x++;
			break;

		case DIRECTION_SOUTHWEST:
			pos.x--;
			pos.y++;
			break;

		case DIRECTION_NORTHWEST:
			pos.x--;
			pos.y--;
			break;

		case DIRECTION_NORTHEAST:
			pos.x++;
			pos.y--;
			break;

		case DIRECTION_SOUTHEAST:
			pos.x++;
			pos.y++;
			break;

		default:
			break;
	}

	return pos;
}

Direction getDirectionTo(const Position& from, const Position& to)
{
	Direction dir;

	int32_t x_offset = Position::getOffsetX(from, to);
	if (x_offset < 0) {
		dir = DIRECTION_EAST;
		x_offset = std::abs(x_offset);
	} else {
		dir = DIRECTION_WEST;
	}

	int32_t y_offset = Position::getOffsetY(from, to);
	if (y_offset >= 0) {
		if (y_offset > x_offset) {
			dir = DIRECTION_NORTH;
		} else if (y_offset == x_offset) {
			if (dir == DIRECTION_EAST) {
				dir = DIRECTION_NORTHEAST;
			} else {
				dir = DIRECTION_NORTHWEST;
			}
		}
	} else {
		y_offset = std::abs(y_offset);
		if (y_offset > x_offset) {
			dir = DIRECTION_SOUTH;
		} else if (y_offset == x_offset) {
			if (dir == DIRECTION_EAST) {
				dir = DIRECTION_SOUTHEAST;
			} else {
				dir = DIRECTION_SOUTHWEST;
			}
		}
	}
	return dir;
}

using MagicEffectNames = std::unordered_map<std::string, MagicEffectClasses>;
using ShootTypeNames = std::unordered_map<std::string, ShootType_t>;
using CombatTypeNames = std::unordered_map<CombatType_t, std::string, std::hash<int32_t>>;
using AmmoTypeNames = std::unordered_map<std::string, Ammo_t>;
using WeaponActionNames = std::unordered_map<std::string, WeaponAction_t>;
using SkullNames = std::unordered_map<std::string, Skulls_t>;

MagicEffectNames magicEffectNames = {
	{"redspark",		CONST_ME_DRAWBLOOD},//1
	{"bluebubble",		CONST_ME_LOSEENERGY},//2
	{"poff",		CONST_ME_POFF},//3
	{"yellowspark",		CONST_ME_BLOCKHIT},//4
	{"explosionarea",	CONST_ME_EXPLOSIONAREA},//5
	{"explosion",		CONST_ME_EXPLOSIONHIT},//6
	{"firearea",		CONST_ME_FIREAREA},//7
	{"yellowbubble",	CONST_ME_YELLOW_RINGS},//8
	{"greenbubble",		CONST_ME_GREEN_RINGS},//9
	{"blackspark",		CONST_ME_HITAREA},//10
	{"teleport",		CONST_ME_TELEPORT},//11
	{"energy",		CONST_ME_ENERGYHIT},//12
	{"blueshimmer",		CONST_ME_MAGIC_BLUE},//13
	{"redshimmer",		CONST_ME_MAGIC_RED},//14
	{"greenshimmer",	CONST_ME_MAGIC_GREEN},//15
	{"fire",		CONST_ME_HITBYFIRE},//16
	{"greenspark",		CONST_ME_HITBYPOISON},//17
	{"mortarea",		CONST_ME_MORTAREA},//18
	{"greennote",		CONST_ME_SOUND_GREEN},//19
	{"rednote",		CONST_ME_SOUND_RED},//20
	{"poison",		CONST_ME_POISONAREA},//21
	{"yellownote",		CONST_ME_SOUND_YELLOW},//22
	{"purplenote",		CONST_ME_SOUND_PURPLE},//23
	{"bluenote",		CONST_ME_SOUND_BLUE},//24
	{"whitenote",		CONST_ME_SOUND_WHITE},//25
	{"dice",		CONST_ME_CRAPS},//26
	{"poisoncircle",		CONST_ME_POISONCIRCLE},//27
	{"icetornado",		CONST_ME_ICETORNADO},//28
	{"holystrike",		CONST_ME_HOLYSTIRKE},//29
	{"icestrike",		CONST_ME_ICESTRIKE},//30
	{"icepilar",		CONST_ME_ICEPILAR},//31
	{"watersplash",		CONST_ME_WATERSPLASH},//32
	{"icepilar2",		CONST_ME_ICEPILAR2},//33
	{"trueshot",		CONST_ME_TRUESHOT},//34
	{"hearts",		CONST_ME_HEARTS},//35
	{"iceattack",		CONST_ME_ICEATTACK},//36
	{"spoff",		CONST_ME_SPOFF},//37
	{"smallclouds",		CONST_ME_SMALLCLOUDS},//38
	{"manademon",		CONST_ME_MANADEMON},//39
	{"rockstrike",		CONST_ME_ROCKSTRIKE},//40
	{"awakesd",		CONST_ME_AWAKESD},//41
	{"awakeenergy",		CONST_ME_AWAKEENERGY},//42
	{"awakefire",		CONST_ME_AWAKEFIRE},//43
	{"abyssfire",		CONST_ME_ABYSSFIRE},//44
	{"divinefire",		CONST_ME_DIVINEFIRE},//45
	{"manaexplosion",		CONST_ME_MANAEXPLOSION},//46
	{"smokeexplosion",		CONST_ME_SMOKEEXPLOSION},//47
	{"poisonexplosion",		CONST_ME_POISONEXPLOSION},//48
	{"weaponattack",		CONST_ME_WEAPONATTACK},//49
	{"punch",		CONST_ME_PUNCH},//50
	{"singleslashred",		CONST_ME_SINGLESLASHRED},//51
	{"singleslashgray",		CONST_ME_SINGLESLASHGRAY},//52
	{"tripleattack",		CONST_ME_TRIPLEATTACK},//53
	{"icestar",		CONST_ME_ICESTAR},//54
	{"prottect",		CONST_ME_PROTECT},//55
	{"darkorb",		CONST_ME_DARKORB},//56
	{"greenorb",		CONST_ME_GREENORB},//57
	{"divinebuff",		CONST_ME_DIVINEBUFF},//58
	{"groundwave",		CONST_ME_GROUNDWAVE},//59
	{"groundavalanche",		CONST_ME_GROUNDAVALANCHE},//60
	{"abysswave",		CONST_ME_ABYSSWAVE},//61
	{"fireespiral",		CONST_ME_FIREESPIRAL},//62
	{"skull",		CONST_ME_SKULL},//63
	{"absorbmana",		CONST_ME_ABSORBMANA},//63
	{"bluefire",		CONST_ME_BLUEFIRE},//64
	{"bubbles",		CONST_ME_BUBBLES},//65
	{"fireimpact",		CONST_ME_FIREIMPACT},//66
	{"newfire",		CONST_ME_NEWFIRE},//67
	{"greatexplosion",		CONST_ME_GREATEXPLOSION},//68
	{"newexplosion",		CONST_ME_NEWEXPLOSION},//69
	{"windtornado",		CONST_ME_WINDTORNADO},//70
	{"newexplosion2",		CONST_ME_NEWEXPLOSION2},//71
	{"windattack",		CONST_ME_WINDATTACK},//72
	{"marble",		CONST_ME_MARBLE},//73
	{"redaura",		CONST_ME_REDAURA},//74
	{"bluecircle",		CONST_ME_BLUECIRCLE},//75
	{"pink",		CONST_ME_PINK},//76
	{"abyssred",		CONST_ME_ABYSSRED},//77
	{"newexplosion3",		CONST_ME_NEWEXPLOSION3},//78
	{"abyssblue",		CONST_ME_ABYSSBLUE},//79
	{"icefire",		CONST_ME_ICEFIRE},//80
	{"blueaura",		CONST_ME_BLUEAURA},//81
	{"deserttornado",		CONST_ME_DESERTTORNADO},//82
	{"gaystrike",		CONST_ME_GAYSTIRKE},//83
	{"whiteaura",		CONST_ME_WHITEAURA},//84
	{"patada",		CONST_ME_PATADA},//85
	{"protectblue",		CONST_ME_PROTECTBLUE},//86
	{"earthquake",		CONST_ME_EARTHQUAKE},//87
	{"clawgreen",		CONST_ME_CLAWGREEN},//88
	{"clawred",		CONST_ME_CLAWRED},//89
	{"greenaura",		CONST_ME_GREENAURA},//90
	{"yellowaura",		CONST_ME_YELLOWAURA},//91
	{"digimon",		CONST_ME_DIGIMON},//92
	{"megaexplosion",		CONST_ME_MEGAEXPLOSION},//93
	{"firerain",		CONST_ME_FIRERAIN},//94
	{"energyaura",		CONST_ME_ENERGYAURA},//95
	{"lagfire",		CONST_ME_LAGFIRE},//96
	{"rollingbone",		CONST_ME_ROLLINGBONE},//97
	{"bonestrike",		CONST_ME_BONESTRIKE},//98
	{"icegrave",		CONST_ME_ICEGRAVE},//99
	{"brokenrock",		CONST_ME_BROKENROCK},//
	{"siphoedfire",		CONST_ME_SIPHOEDFIRE},//
	{"siphoedexplosion",		CONST_ME_SIPHOEDEXPLOSION},//
	{"flamearea",		CONST_ME_FLAMEAREA},//
	{"meteor",		CONST_ME_METEOR},//
	{"newexplosion4",		CONST_ME_NEWEXPLOSION4},//
	{"fireralinho",		CONST_ME_FIRERALINHO},//
	{"mudspine",		CONST_ME_MUDSPINE},//
	{"rockspine",		CONST_ME_ROCKSPINE},//
	{"firetornado",		CONST_ME_FIRETORNADO},//
	{"tornado",		CONST_ME_TORNADO},//
};

ShootTypeNames shootTypeNames = {
	{"spear",		CONST_ANI_SPEAR},//1
	{"bolt",		CONST_ANI_BOLT},//2
	{"arrow",		CONST_ANI_ARROW},//3
	{"fire",		CONST_ANI_FIRE},//4
	{"energy",		CONST_ANI_ENERGY},//5
	{"poisonarrow",		CONST_ANI_POISONARROW},//6
	{"burstarrow",		CONST_ANI_BURSTARROW},//7
	{"throwingstar",	CONST_ANI_THROWINGSTAR},//8
	{"throwingknife",	CONST_ANI_THROWINGKNIFE},//9
	{"smallstone",		CONST_ANI_SMALLSTONE},//10
	{"death",		CONST_ANI_DEATH},//11
	{"largerock",		CONST_ANI_LARGEROCK},//12
	{"snowball",		CONST_ANI_SNOWBALL},//13
	{"powerbolt",		CONST_ANI_POWERBOLT},//14
	{"poison",		CONST_ANI_POISON},//15
	{"firearrow",	CONST_ANI_FIREARROW},//16
	{"spikedarrow",	CONST_ANI_SPIKEDARROW},//17
	{"thunderarrow",	CONST_ANI_THUNDERARROW},//18
	{"spikedbolt",		CONST_ANI_SPIKEDBOLT},//19
	{"piercebolt",		CONST_ANI_PIERCEBOLT},//20
	{"huntarrow",		CONST_ANI_HUNTARROW},//21
	{"hunterspear",		CONST_ANI_HUNTERSPEAR},//22
	{"firebolt",		CONST_ANI_FIREBOLT},//23
	{"icespikes",	CONST_ANI_ICESPIKES},//24
	{"bluemissile",	CONST_ANI_BLUEMISSILE},//25
	{"iceslash",	CONST_ANI_ICESLASH},//26
	{"mortbolt",	CONST_ANI_MORTBOLT},//27
	{"largepoison",	CONST_ANI_LARGEPOISON},//28
	{"smallice",			CONST_ANI_SMALLICE},//29
	{"death",		CONST_ANI_DEATH},//30
	{"greenarrow",		CONST_ANI_GREENARROW},//31
	{"moss",		CONST_ANI_MOSS},//32
	{"smallholy",		CONST_ANI_SMALLHOLY},//33
	{"ice",				CONST_ANI_ICE},//34
	{"energyball",		CONST_ANI_ENERGYBALL},//35
	{"silverarrow",		CONST_ANI_SILVERARROW},//36
	{"copperarrow",		CONST_ANI_COPPERARROW},//37
	{"energyarrow",		CONST_ANI_ENERGYARROW},//38
	{"sd",		CONST_ANI_SD},//39
	{"largeholly",		CONST_ANI_LARGEHOLLY},//40
	{"largemoss",		CONST_ANI_LARGEMOSS},//41
	{"largeice",		CONST_ANI_LARGEICE},//42
	{"thunderbolt",		CONST_ANI_THUNDERBOLT},//43
	{"molotov",		CONST_ANI_MOLOTOV},//44
	{"kunai",		CONST_ANI_KUNAI},//45
	{"redarrow",		CONST_ANI_REDARROW},//46
	{"brownarrow",		CONST_ANI_BROWNARROW},//47
	{"sword",		CONST_ANI_SWORD},//48
	{"axe",		CONST_ANI_AXE},//49
	{"fireball",		CONST_ANI_FIREBALL},//50
	{"fireball2",		CONST_ANI_FIREBALL2},//51
	{"fireball3",		CONST_ANI_FIREBALL3},//52
	{"slash",		CONST_ANI_SLASH},//53
	{"manaball",		CONST_ANI_MANABALL},//54
	{"arcaneball",		CONST_ANI_ARCANEBALL},//55
	{"arcaneball2",		CONST_ANI_ARCANEBALL2},//56
	{"arcaneball3",		CONST_ANI_ARCANEBALL3},//57
	{"arcaneball4",		CONST_ANI_ARCANEBALL4},//58
	{"firemissile",		CONST_ANI_FIREMISSILE},//59
	{"energymissile",		CONST_ANI_ENERGYMISSILE},//60
	{"fire2",		CONST_ANI_FIRE2},//60
	{"smallarcane",		CONST_ANI_SMALLARCANE},//60
	{"arcanebug",		CONST_ANI_ARCANEBUG},//60
	{"sai",		CONST_ANI_SAI},//60
	{"sword2",		CONST_ANI_SWORD2},//60
	{"redwave",		CONST_ANI_REDWAVE},//60
	{"water",		CONST_ANI_WATER},//60
	{"fireyellow",		CONST_ANI_FIREYELLOW},//60
	{"bomb",		CONST_ANI_BOMB},//60
	{"blackwave",		CONST_ANI_BLACKWAVE},//60
	{"whitewave",		CONST_ANI_WHITEWAVE},//60
	{"bone",		CONST_ANI_BONE},//60
	{"firerock",		CONST_ANI_FIREROCK},//60
	{"spikes",		CONST_ANI_SPIKES},//60
	{"spike",		CONST_ANI_SPIKE},//60
	{"waterball",		CONST_ANI_WATERBALL},//60
	{"pinkmissile",		CONST_ANI_PINKMISSILE},//60
	{"energywave",		CONST_ANI_ENERGYWAVE},//60
	{"horn",		CONST_ANI_HORN},//60
	{"holyball",		CONST_ANI_HOLYBALL},//60
	{"smallbluewave",		CONST_ANI_SMALLBLUEWAVE},//60
	{"bluewave",		CONST_ANI_BLUEWAVE},//60
	{"giantrock",		CONST_ANI_GIANTROCK},//60
	{"thunderlance",		CONST_ANI_THUNDERLANCE},//60
	{"fire3",		CONST_ANI_FIRE3},//60
	{"waterbubble",		CONST_ANI_WATERBUBBLE},//60
	{"largerock",		CONST_ANI_LARGEROCK},//60
	{"icerock",		CONST_ANI_ICEROCK},//60
};

CombatTypeNames combatTypeNames = {
	{COMBAT_PHYSICALDAMAGE, 	"physical"},
	{COMBAT_ENERGYDAMAGE, 		"energy"},
	{COMBAT_EARTHDAMAGE, 		"earth"},
	{COMBAT_FIREDAMAGE, 		"fire"},
	{COMBAT_UNDEFINEDDAMAGE, 	"undefined"},
	{COMBAT_LIFEDRAIN, 		"lifedrain"},
	{COMBAT_MANADRAIN, 		"manadrain"},
	{COMBAT_HEALING, 		"healing"},
	{COMBAT_DROWNDAMAGE, 		"drown"},
	{COMBAT_COLDDAMAGE, 		"cold"},
	{COMBAT_DIVINEDAMAGE, 		"divine"},
	{COMBAT_DEATHDAMAGE, 		"death"},
};

AmmoTypeNames ammoTypeNames = {
	{"spear",		AMMO_SPEAR},
	{"bolt",		AMMO_BOLT},
	{"arrow",		AMMO_ARROW},
	{"poisonarrow",		AMMO_ARROW},
	{"burstarrow",		AMMO_ARROW},
	{"throwingstar",	AMMO_THROWINGSTAR},
	{"throwingknife",	AMMO_THROWINGKNIFE},
	{"smallstone",		AMMO_STONE},
	{"largerock",		AMMO_STONE},
	{"snowball",		AMMO_SNOWBALL},
	{"powerbolt",		AMMO_BOLT},
	{"infernalbolt",	AMMO_BOLT},
	{"huntingspear",	AMMO_SPEAR},
	{"enchantedspear",	AMMO_SPEAR},
	{"royalspear",		AMMO_SPEAR},
	{"sniperarrow",		AMMO_ARROW},
	{"onyxarrow",		AMMO_ARROW},
	{"piercingbolt",	AMMO_BOLT},
	{"etherealspear",	AMMO_SPEAR},
	{"flasharrow",		AMMO_ARROW},
	{"flammingarrow",	AMMO_ARROW},
	{"shiverarrow",		AMMO_ARROW},
	{"eartharrow",		AMMO_ARROW},
};

WeaponActionNames weaponActionNames = {
	{"move",		WEAPONACTION_MOVE},
	{"removecharge",	WEAPONACTION_REMOVECHARGE},
	{"removecount",		WEAPONACTION_REMOVECOUNT},
};

SkullNames skullNames = {
	{"none",	SKULL_NONE},
	{"yellow",	SKULL_YELLOW},
	{"green",	SKULL_GREEN},
	{"white",	SKULL_WHITE},
	{"red",		SKULL_RED},
	{"black",	SKULL_BLACK},
};

MagicEffectClasses getMagicEffect(const std::string& strValue)
{
	auto magicEffect = magicEffectNames.find(strValue);
	if (magicEffect != magicEffectNames.end()) {
		return magicEffect->second;
	}
	return CONST_ME_NONE;
}

ShootType_t getShootType(const std::string& strValue)
{
	auto shootType = shootTypeNames.find(strValue);
	if (shootType != shootTypeNames.end()) {
		return shootType->second;
	}
	return CONST_ANI_NONE;
}

std::string getCombatName(CombatType_t combatType)
{
	auto combatName = combatTypeNames.find(combatType);
	if (combatName != combatTypeNames.end()) {
		return combatName->second;
	}
	return "unknown";
}

Ammo_t getAmmoType(const std::string& strValue)
{
	auto ammoType = ammoTypeNames.find(strValue);
	if (ammoType != ammoTypeNames.end()) {
		return ammoType->second;
	}
	return AMMO_NONE;
}

WeaponAction_t getWeaponAction(const std::string& strValue)
{
	auto weaponAction = weaponActionNames.find(strValue);
	if (weaponAction != weaponActionNames.end()) {
		return weaponAction->second;
	}
	return WEAPONACTION_NONE;
}

Skulls_t getSkullType(const std::string& strValue)
{
	auto skullType = skullNames.find(strValue);
	if (skullType != skullNames.end()) {
		return skullType->second;
	}
	return SKULL_NONE;
}

std::string getSkillName(uint8_t skillid)
{
	switch (skillid) {
		case SKILL_FIST:
			return "fist fighting";

		case SKILL_CLUB:
			return "club fighting";

		case SKILL_SWORD:
			return "sword fighting";

		case SKILL_AXE:
			return "axe fighting";

		case SKILL_DISTANCE:
			return "distance fighting";

		case SKILL_SHIELD:
			return "shielding";

		case SKILL_FISHING:
			return "fishing";

		case SKILL_MAGLEVEL:
			return "magic level";

		case SKILL_LEVEL:
			return "level";

		default:
			return "unknown";
	}
}

uint32_t adlerChecksum(const uint8_t* data, size_t length)
{
	if (length > NETWORKMESSAGE_MAXSIZE) {
		return 0;
	}

	const uint16_t adler = 65521;

	uint32_t a = 1, b = 0;

	while (length > 0) {
		size_t tmp = length > 5552 ? 5552 : length;
		length -= tmp;

		do {
			a += *data++;
			b += a;
		} while (--tmp);

		a %= adler;
		b %= adler;
	}

	return (b << 16) | a;
}

std::string ucfirst(std::string str)
{
	for (char& i : str) {
		if (i != ' ') {
			i = toupper(i);
			break;
		}
	}
	return str;
}

std::string ucwords(std::string str)
{
	size_t strLength = str.length();
	if (strLength == 0) {
		return str;
	}

	str[0] = toupper(str.front());
	for (size_t i = 1; i < strLength; ++i) {
		if (str[i - 1] == ' ') {
			str[i] = toupper(str[i]);
		}
	}

	return str;
}

bool booleanString(const std::string& str)
{
	if (str.empty()) {
		return false;
	}

	char ch = tolower(str.front());
	return ch != 'f' && ch != 'n' && ch != '0';
}

std::string getWeaponName(WeaponType_t weaponType)
{
	switch (weaponType) {
		case WEAPON_SWORD: return "sword";
		case WEAPON_CLUB: return "club";
		case WEAPON_AXE: return "axe";
		case WEAPON_DISTANCE: return "distance";
		case WEAPON_WAND: return "wand";
		case WEAPON_AMMO: return "ammunition";
		default: return std::string();
	}
}

size_t combatTypeToIndex(CombatType_t combatType)
{
	switch (combatType) {
		case COMBAT_PHYSICALDAMAGE:
			return 0;
		case COMBAT_ENERGYDAMAGE:
			return 1;
		case COMBAT_EARTHDAMAGE:
			return 2;
		case COMBAT_FIREDAMAGE:
			return 3;
		case COMBAT_UNDEFINEDDAMAGE:
			return 4;
		case COMBAT_LIFEDRAIN:
			return 5;
		case COMBAT_MANADRAIN:
			return 6;
		case COMBAT_HEALING:
			return 7;
		case COMBAT_DROWNDAMAGE:
			return 8;
		case COMBAT_COLDDAMAGE:
			return 9;
		case COMBAT_DIVINEDAMAGE:
			return 10;
		case COMBAT_DEATHDAMAGE:
			return 11;
		default:
			return 0;
	}
}

CombatType_t indexToCombatType(size_t v)
{
	return static_cast<CombatType_t>(1 << v);
}

uint8_t serverFluidToClient(uint8_t serverFluid)
{
	uint8_t size = sizeof(clientToServerFluidMap) / sizeof(uint8_t);
	for (uint8_t i = 0; i < size; ++i) {
		if (clientToServerFluidMap[i] == serverFluid) {
			return i;
		}
	}
	return 0;
}

uint8_t clientFluidToServer(uint8_t clientFluid)
{
	uint8_t size = sizeof(clientToServerFluidMap) / sizeof(uint8_t);
	if (clientFluid >= size) {
		return 0;
	}
	return clientToServerFluidMap[clientFluid];
}

itemAttrTypes stringToItemAttribute(const std::string& str)
{
	if (str == "aid") {
		return ITEM_ATTRIBUTE_ACTIONID;
	} else if (str == "uid") {
		return ITEM_ATTRIBUTE_UNIQUEID;
	} else if (str == "description") {
		return ITEM_ATTRIBUTE_DESCRIPTION;
	} else if (str == "text") {
		return ITEM_ATTRIBUTE_TEXT;
	} else if (str == "date") {
		return ITEM_ATTRIBUTE_DATE;
	} else if (str == "writer") {
		return ITEM_ATTRIBUTE_WRITER;
	} else if (str == "name") {
		return ITEM_ATTRIBUTE_NAME;
	} else if (str == "article") {
		return ITEM_ATTRIBUTE_ARTICLE;
	} else if (str == "pluralname") {
		return ITEM_ATTRIBUTE_PLURALNAME;
	} else if (str == "weight") {
		return ITEM_ATTRIBUTE_WEIGHT;
	} else if (str == "attack") {
		return ITEM_ATTRIBUTE_ATTACK;
	} else if (str == "defense") {
		return ITEM_ATTRIBUTE_DEFENSE;
	} else if (str == "extradefense") {
		return ITEM_ATTRIBUTE_EXTRADEFENSE;
	} else if (str == "armor") {
		return ITEM_ATTRIBUTE_ARMOR;
	} else if (str == "hitchance") {
		return ITEM_ATTRIBUTE_HITCHANCE;
	} else if (str == "shootrange") {
		return ITEM_ATTRIBUTE_SHOOTRANGE;
	} else if (str == "owner") {
		return ITEM_ATTRIBUTE_OWNER;
	} else if (str == "duration") {
		return ITEM_ATTRIBUTE_DURATION;
	} else if (str == "decaystate") {
		return ITEM_ATTRIBUTE_DECAYSTATE;
	} else if (str == "corpseowner") {
		return ITEM_ATTRIBUTE_CORPSEOWNER;
	} else if (str == "charges") {
		return ITEM_ATTRIBUTE_CHARGES;
	} else if (str == "fluidtype") {
		return ITEM_ATTRIBUTE_FLUIDTYPE;
	} else if (str == "doorid") {
		return ITEM_ATTRIBUTE_DOORID;
	} else if (str == "special") {
		return ITEM_ATTRIBUTE_SPECIAL;
	} else if (str == "imbuingslots") {
		return ITEM_ATTRIBUTE_IMBUINGSLOTS;
	}
	return ITEM_ATTRIBUTE_NONE;
}

std::string getFirstLine(const std::string& str)
{
	std::string firstLine;
	firstLine.reserve(str.length());
	for (const char c : str) {
		if (c == '\n') {
			break;
		}
		firstLine.push_back(c);
	}
	return firstLine;
}

const char* getReturnMessage(ReturnValue value)
{
	switch (value) {
		case RETURNVALUE_REWARDCHESTISEMPTY:
			return "The chest is currently empty. You did not take part in any battles in the last seven days or already claimed your reward.";

		case RETURNVALUE_DESTINATIONOUTOFREACH:
			return "Destination is out of reach.";

		case RETURNVALUE_NOTMOVEABLE:
			return "You cannot move this object.";

		case RETURNVALUE_DROPTWOHANDEDITEM:
			return "Drop the double-handed object first.";

		case RETURNVALUE_BOTHHANDSNEEDTOBEFREE:
			return "Both hands need to be free.";

		case RETURNVALUE_CANNOTBEDRESSED:
			return "You cannot dress this object there.";

		case RETURNVALUE_PUTTHISOBJECTINYOURHAND:
			return "Put this object in your hand.";

		case RETURNVALUE_PUTTHISOBJECTINBOTHHANDS:
			return "Put this object in both hands.";

		case RETURNVALUE_CANONLYUSEONEWEAPON:
			return "You may only use one weapon.";

		case RETURNVALUE_TOOFARAWAY:
			return "Too far away.";

		case RETURNVALUE_FIRSTGODOWNSTAIRS:
			return "First go downstairs.";

		case RETURNVALUE_FIRSTGOUPSTAIRS:
			return "First go upstairs.";

		case RETURNVALUE_NOTENOUGHCAPACITY:
			return "This object is too heavy for you to carry.";

		case RETURNVALUE_CONTAINERNOTENOUGHROOM:
			return "You cannot put more objects in this container.";

		case RETURNVALUE_NEEDEXCHANGE:
		case RETURNVALUE_NOTENOUGHROOM:
			return "There is not enough room.";

		case RETURNVALUE_CANNOTPICKUP:
			return "You cannot take this object.";

		case RETURNVALUE_CANNOTTHROW:
			return "You cannot throw there.";

		case RETURNVALUE_THEREISNOWAY:
			return "There is no way.";

		case RETURNVALUE_THISISIMPOSSIBLE:
			return "This is impossible.";

		case RETURNVALUE_PLAYERISPZLOCKED:
			return "You can not enter a protection zone after attacking another player.";

		case RETURNVALUE_PLAYERISNOTINVITED:
			return "You are not invited.";

		case RETURNVALUE_CREATUREDOESNOTEXIST:
			return "Creature does not exist.";

		case RETURNVALUE_DEPOTISFULL:
			return "You cannot put more items in this depot.";

		case RETURNVALUE_CANNOTUSETHISOBJECT:
			return "You cannot use this object.";

		case RETURNVALUE_PLAYERWITHTHISNAMEISNOTONLINE:
			return "A player with this name is not online.";

		case RETURNVALUE_NOTREQUIREDLEVELTOUSERUNE:
			return "You do not have the required magic level to use this rune.";

		case RETURNVALUE_YOUAREALREADYTRADING:
			return "You are already trading.";

		case RETURNVALUE_THISPLAYERISALREADYTRADING:
			return "This player is already trading.";

		case RETURNVALUE_YOUMAYNOTLOGOUTDURINGAFIGHT:
			return "You may not logout during or immediately after a fight!";

		case RETURNVALUE_DIRECTPLAYERSHOOT:
			return "You are not allowed to shoot directly on players.";

		case RETURNVALUE_NOTENOUGHLEVEL:
			return "You do not have enough level.";

		case RETURNVALUE_NOTENOUGHMAGICLEVEL:
			return "You do not have enough magic level.";

		case RETURNVALUE_NOTENOUGHMANA:
			return "You do not have enough mana.";

		case RETURNVALUE_NOTENOUGHSOUL:
			return "You do not have enough soul.";

		case RETURNVALUE_YOUAREEXHAUSTED:
			return "You are exhausted.";

		case RETURNVALUE_CANONLYUSETHISRUNEONCREATURES:
			return "You can only use this rune on creatures.";

		case RETURNVALUE_PLAYERISNOTREACHABLE:
			return "Player is not reachable.";

		case RETURNVALUE_CREATUREISNOTREACHABLE:
			return "Creature is not reachable.";

		case RETURNVALUE_ACTIONNOTPERMITTEDINPROTECTIONZONE:
			return "This action is not permitted in a protection zone.";

		case RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER:
			return "You may not attack this player.";

		case RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE:
			return "You may not attack this creature.";

		case RETURNVALUE_YOUMAYNOTATTACKAPERSONINPROTECTIONZONE:
			return "You may not attack a person in a protection zone.";

		case RETURNVALUE_YOUMAYNOTATTACKAPERSONWHILEINPROTECTIONZONE:
			return "You may not attack a person while you are in a protection zone.";

		case RETURNVALUE_YOUCANONLYUSEITONCREATURES:
			return "You can only use it on creatures.";

		case RETURNVALUE_TURNSECUREMODETOATTACKUNMARKEDPLAYERS:
			return "Turn secure mode off if you really want to attack unmarked players.";

		case RETURNVALUE_YOUNEEDPREMIUMACCOUNT:
			return "You need a premium account.";

		case RETURNVALUE_YOUNEEDTOLEARNTHISSPELL:
			return "You need to learn this spell first.";

		case RETURNVALUE_YOURVOCATIONCANNOTUSETHISSPELL:
			return "Your vocation cannot use this spell.";

		case RETURNVALUE_YOUNEEDAWEAPONTOUSETHISSPELL:
			return "You need to equip a weapon to use this spell.";

		case RETURNVALUE_PLAYERISPZLOCKEDLEAVEPVPZONE:
			return "You can not leave a pvp zone after attacking another player.";

		case RETURNVALUE_PLAYERISPZLOCKEDENTERPVPZONE:
			return "You can not enter a pvp zone after attacking another player.";

		case RETURNVALUE_ACTIONNOTPERMITTEDINANOPVPZONE:
			return "This action is not permitted in a non pvp zone.";

		case RETURNVALUE_YOUCANNOTLOGOUTHERE:
			return "You can not logout here.";

		case RETURNVALUE_YOUNEEDAMAGICITEMTOCASTSPELL:
			return "You need a magic item to cast this spell.";

		case RETURNVALUE_CANNOTCONJUREITEMHERE:
			return "You cannot conjure items here.";

		case RETURNVALUE_YOUNEEDTOSPLITYOURSPEARS:
			return "You need to split your spears first.";

		case RETURNVALUE_NAMEISTOOAMBIGUOUS:
			return "Player name is ambiguous.";

		case RETURNVALUE_CANONLYUSEONESHIELD:
			return "You may use only one shield.";

		case RETURNVALUE_NOPARTYMEMBERSINRANGE:
			return "No party members in range.";

		case RETURNVALUE_YOUARENOTTHEOWNER:
			return "You are not the owner.";

		case RETURNVALUE_NOSUCHRAIDEXISTS:
			return "No such raid exists.";

		case RETURNVALUE_ANOTHERRAIDISALREADYEXECUTING:
			return "Another raid is already executing.";

		case RETURNVALUE_TRADEPLAYERFARAWAY:
			return "Trade player is too far away.";

		case RETURNVALUE_YOUDONTOWNTHISHOUSE:
			return "You don't own this house.";

		case RETURNVALUE_TRADEPLAYERALREADYOWNSAHOUSE:
			return "Trade player already owns a house.";

		case RETURNVALUE_TRADEPLAYERHIGHESTBIDDER:
			return "Trade player is currently the highest bidder of an auctioned house.";

		case RETURNVALUE_YOUCANNOTTRADETHISHOUSE:
			return "You can not trade this house.";

		case RETURNVALUE_NOTENOUGHFISTLEVEL:
			return "You do not have enough fist level";

		case RETURNVALUE_NOTENOUGHCLUBLEVEL:
			return "You do not have enough club level";

		case RETURNVALUE_NOTENOUGHSWORDLEVEL:
			return "You do not have enough sword level";

		case RETURNVALUE_NOTENOUGHAXELEVEL:
			return "You do not have enough axe level";

		case RETURNVALUE_NOTENOUGHDISTANCELEVEL:
			return "You do not have enough distance level";

		case RETURNVALUE_NOTENOUGHSHIELDLEVEL:
			return "You do not have enough shielding level";

		case RETURNVALUE_NOTENOUGHFISHLEVEL:
			return "You do not have enough fishing level";

		default: // RETURNVALUE_NOTPOSSIBLE, etc
			return "Sorry, not possible.";
	}
}

int64_t OTSYS_TIME()
{
	return std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
}
