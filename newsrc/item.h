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

#ifndef FS_ITEM_H_009A319FB13D477D9EEFFBBD9BB83562
#define FS_ITEM_H_009A319FB13D477D9EEFFBBD9BB83562

#include "cylinder.h"
#include "thing.h"
#include "items.h"

#include <deque>

class Creature;
class Player;
class Container;
class Depot;
class Teleport;
class TrashHolder;
class Mailbox;
class Door;
class MagicField;
class BedItem;

enum ITEMPROPERTY {
	CONST_PROP_BLOCKSOLID = 0,
	CONST_PROP_HASHEIGHT,
	CONST_PROP_BLOCKPROJECTILE,
	CONST_PROP_BLOCKPATH,
	CONST_PROP_ISVERTICAL,
	CONST_PROP_ISHORIZONTAL,
	CONST_PROP_MOVEABLE,
	CONST_PROP_IMMOVABLEBLOCKSOLID,
	CONST_PROP_IMMOVABLEBLOCKPATH,
	CONST_PROP_IMMOVABLENOFIELDBLOCKPATH,
	CONST_PROP_NOFIELDBLOCKPATH,
	CONST_PROP_SUPPORTHANGABLE,
};

enum TradeEvents_t {
	ON_TRADE_TRANSFER,
	ON_TRADE_CANCEL,
};

enum ItemDecayState_t : uint8_t {
	DECAYING_FALSE = 0,
	DECAYING_TRUE,
	DECAYING_PENDING,
};

enum AttrTypes_t {
	//ATTR_DESCRIPTION = 1,
	//ATTR_EXT_FILE = 2,
	ATTR_TILE_FLAGS = 3,
	ATTR_ACTION_ID = 4,
	ATTR_UNIQUE_ID = 5,
	ATTR_TEXT = 6,
	ATTR_DESC = 7,
	ATTR_TELE_DEST = 8,
	ATTR_ITEM = 9,
	ATTR_DEPOT_ID = 10,
	//ATTR_EXT_SPAWN_FILE = 11,
	ATTR_RUNE_CHARGES = 12,
	//ATTR_EXT_HOUSE_FILE = 13,
	ATTR_HOUSEDOORID = 14,
	ATTR_COUNT = 15,
	ATTR_DURATION = 16,
	ATTR_DECAYING_STATE = 17,
	ATTR_WRITTENDATE = 18,
	ATTR_WRITTENBY = 19,
	ATTR_SLEEPERGUID = 20,
	ATTR_SLEEPSTART = 21,
	ATTR_CHARGES = 22,
	ATTR_CONTAINER_ITEMS = 23,
	ATTR_NAME = 24,
	ATTR_ARTICLE = 25,
	ATTR_PLURALNAME = 26,
	ATTR_WEIGHT = 27,
	ATTR_ATTACK = 28,
	ATTR_DEFENSE = 29,
	ATTR_EXTRADEFENSE = 30,
	ATTR_ARMOR = 31,
	ATTR_HITCHANCE = 32,
	ATTR_SHOOTRANGE = 33,
	ATTR_SPECIAL = 34,
	ATTR_IMBUINGSLOTS = 35,
};

enum Attr_ReadValue {
	ATTR_READ_CONTINUE,
	ATTR_READ_ERROR,
	ATTR_READ_END,
};

class ItemAttributes
{
	public:
		ItemAttributes() = default;

		void setSpecialDescription(const std::string& desc) {
			setStrAttr(ITEM_ATTRIBUTE_DESCRIPTION, desc);
		}
		const std::string& getSpecialDescription() const {
			return getStrAttr(ITEM_ATTRIBUTE_DESCRIPTION);
		}

		void setText(const std::string& text) {
			setStrAttr(ITEM_ATTRIBUTE_TEXT, text);
		}
		void resetText() {
			removeAttribute(ITEM_ATTRIBUTE_TEXT);
		}
		const std::string& getText() const {
			return getStrAttr(ITEM_ATTRIBUTE_TEXT);
		}

		void setDate(int32_t n) {
			setIntAttr(ITEM_ATTRIBUTE_DATE, n);
		}
		void resetDate() {
			removeAttribute(ITEM_ATTRIBUTE_DATE);
		}
		time_t getDate() const {
			return static_cast<time_t>(getIntAttr(ITEM_ATTRIBUTE_DATE));
		}

		void setWriter(const std::string& writer) {
			setStrAttr(ITEM_ATTRIBUTE_WRITER, writer);
		}
		void resetWriter() {
			removeAttribute(ITEM_ATTRIBUTE_WRITER);
		}
		const std::string& getWriter() const {
			return getStrAttr(ITEM_ATTRIBUTE_WRITER);
		}

		void setActionId(uint16_t n) {
			setIntAttr(ITEM_ATTRIBUTE_ACTIONID, n);
		}
		uint16_t getActionId() const {
			return static_cast<uint16_t>(getIntAttr(ITEM_ATTRIBUTE_ACTIONID));
		}

		void setUniqueId(uint16_t n) {
			setIntAttr(ITEM_ATTRIBUTE_UNIQUEID, n);
		}
		uint16_t getUniqueId() const {
			return static_cast<uint16_t>(getIntAttr(ITEM_ATTRIBUTE_UNIQUEID));
		}

		void setCharges(uint16_t n) {
			setIntAttr(ITEM_ATTRIBUTE_CHARGES, n);
		}
		uint16_t getCharges() const {
			return static_cast<uint16_t>(getIntAttr(ITEM_ATTRIBUTE_CHARGES));
		}

		void setFluidType(uint16_t n) {
			setIntAttr(ITEM_ATTRIBUTE_FLUIDTYPE, n);
		}
		uint16_t getFluidType() const {
			return static_cast<uint16_t>(getIntAttr(ITEM_ATTRIBUTE_FLUIDTYPE));
		}

		void setOwner(uint32_t owner) {
			setIntAttr(ITEM_ATTRIBUTE_OWNER, owner);
		}
		uint32_t getOwner() const {
			return getIntAttr(ITEM_ATTRIBUTE_OWNER);
		}

		void setCorpseOwner(uint32_t corpseOwner) {
			setIntAttr(ITEM_ATTRIBUTE_CORPSEOWNER, corpseOwner);
		}
		uint32_t getCorpseOwner() const {
			return getIntAttr(ITEM_ATTRIBUTE_CORPSEOWNER);
		}

		void setDuration(int32_t time) {
			setIntAttr(ITEM_ATTRIBUTE_DURATION, time);
		}
		void decreaseDuration(int32_t time) {
			increaseIntAttr(ITEM_ATTRIBUTE_DURATION, -time);
		}
		uint32_t getDuration() const {
			return getIntAttr(ITEM_ATTRIBUTE_DURATION);
		}

		void setDecaying(ItemDecayState_t decayState) {
			setIntAttr(ITEM_ATTRIBUTE_DECAYSTATE, decayState);
		}
		ItemDecayState_t getDecaying() const {
			return static_cast<ItemDecayState_t>(getIntAttr(ITEM_ATTRIBUTE_DECAYSTATE));
		}

	protected:
		bool hasAttribute(itemAttrTypes type) const {
			return (type & attributeBits) != 0;
		}
		void removeAttribute(itemAttrTypes type);

		static std::string emptyString;

		struct Attribute
		{
			union {
				int64_t integer;
				std::string* string;
			} value;
			itemAttrTypes type;

			explicit Attribute(itemAttrTypes type) : type(type) {
				memset(&value, 0, sizeof(value));
			}
			Attribute(const Attribute& i) {
				type = i.type;
				if (ItemAttributes::isIntAttrType(type)) {
					value.integer = i.value.integer;
				} else if (ItemAttributes::isStrAttrType(type)) {
					value.string = new std::string(*i.value.string);
				} else {
					memset(&value, 0, sizeof(value));
				}
			}
			Attribute(Attribute&& attribute) : value(attribute.value), type(attribute.type) {
				memset(&attribute.value, 0, sizeof(value));
				attribute.type = ITEM_ATTRIBUTE_NONE;
			}
			~Attribute() {
				if (ItemAttributes::isStrAttrType(type)) {
					delete value.string;
				}
			}
			Attribute& operator=(Attribute other) {
				Attribute::swap(*this, other);
				return *this;
			}
			Attribute& operator=(Attribute&& other) {
				if (this != &other) {
					if (ItemAttributes::isStrAttrType(type)) {
						delete value.string;
					}

					value = other.value;
					type = other.type;

					memset(&other.value, 0, sizeof(value));
					other.type = ITEM_ATTRIBUTE_NONE;
				}
				return *this;
			}

			static void swap(Attribute& first, Attribute& second) {
				std::swap(first.value, second.value);
				std::swap(first.type, second.type);
			}
		};

		std::forward_list<Attribute> attributes;
		uint32_t attributeBits = 0;

		const std::string& getStrAttr(itemAttrTypes type) const;
		void setStrAttr(itemAttrTypes type, const std::string& value);

		int64_t getIntAttr(itemAttrTypes type) const;
		void setIntAttr(itemAttrTypes type, int64_t value);
		void increaseIntAttr(itemAttrTypes type, int64_t value);

		const Attribute* getExistingAttr(itemAttrTypes type) const;
		Attribute& getAttr(itemAttrTypes type);

	public:
		static bool isIntAttrType(itemAttrTypes type) {
			return (type & 0x7FFE13) != 0;
		}
		static bool isStrAttrType(itemAttrTypes type) {
			return (type & 0x8001EC) != 0;
		}

		const std::forward_list<Attribute>& getList() const {
			return attributes;
		}

	friend class Item;
};

class Item : virtual public Thing
{
	public:
		//Factory member to create item of right type based on type
		static Item* CreateItem(const uint16_t type, uint16_t count = 0);
		static Container* CreateItemAsContainer(const uint16_t type, uint16_t size);
		static Item* CreateItem(PropStream& propStream);
		static Items items;

		// Constructor for items
		Item(const uint16_t type, uint16_t count = 0);
		Item(const Item& i);
		virtual Item* clone() const;

		virtual ~Item() = default;

		// non-assignable
		Item& operator=(const Item&) = delete;

		bool equals(const Item* otherItem) const;

		Item* getItem() final {
			return this;
		}
		const Item* getItem() const final {
			return this;
		}
		virtual Teleport* getTeleport() {
			return nullptr;
		}
		virtual const Teleport* getTeleport() const {
			return nullptr;
		}
		virtual TrashHolder* getTrashHolder() {
			return nullptr;
		}
		virtual const TrashHolder* getTrashHolder() const {
			return nullptr;
		}
		virtual Mailbox* getMailbox() {
			return nullptr;
		}
		virtual const Mailbox* getMailbox() const {
			return nullptr;
		}
		virtual Door* getDoor() {
			return nullptr;
		}
		virtual const Door* getDoor() const {
			return nullptr;
		}
		virtual MagicField* getMagicField() {
			return nullptr;
		}
		virtual const MagicField* getMagicField() const {
			return nullptr;
		}
		virtual BedItem* getBed() {
			return nullptr;
		}
		virtual const BedItem* getBed() const {
			return nullptr;
		}

		const std::string& getStrAttr(itemAttrTypes type) const {
			if (!attributes) {
				return ItemAttributes::emptyString;
			}
			return attributes->getStrAttr(type);
		}
		void setStrAttr(itemAttrTypes type, const std::string& value) {
			getAttributes()->setStrAttr(type, value);
		}

		int32_t getIntAttr(itemAttrTypes type) const {
			if (!attributes) {
				return 0;
			}
			return attributes->getIntAttr(type);
		}
		void setIntAttr(itemAttrTypes type, int32_t value) {
			getAttributes()->setIntAttr(type, value);
		}
		void increaseIntAttr(itemAttrTypes type, int32_t value) {
			getAttributes()->increaseIntAttr(type, value);
		}

		void removeAttribute(itemAttrTypes type) {
			if (attributes) {
				attributes->removeAttribute(type);
			}
		}
		bool hasAttribute(itemAttrTypes type) const {
			if (!attributes) {
				return false;
			}
			return attributes->hasAttribute(type);
		}

		void setSpecialDescription(const std::string& desc) {
			setStrAttr(ITEM_ATTRIBUTE_DESCRIPTION, desc);
		}
		const std::string& getSpecialDescription() const {
			return getStrAttr(ITEM_ATTRIBUTE_DESCRIPTION);
		}

		void setText(const std::string& text) {
			setStrAttr(ITEM_ATTRIBUTE_TEXT, text);
		}
		void resetText() {
			removeAttribute(ITEM_ATTRIBUTE_TEXT);
		}
		const std::string& getText() const {
			return getStrAttr(ITEM_ATTRIBUTE_TEXT);
		}

		void setDate(int32_t n) {
			setIntAttr(ITEM_ATTRIBUTE_DATE, n);
		}
		void resetDate() {
			removeAttribute(ITEM_ATTRIBUTE_DATE);
		}
		time_t getDate() const {
			return static_cast<time_t>(getIntAttr(ITEM_ATTRIBUTE_DATE));
		}

		void setWriter(const std::string& writer) {
			setStrAttr(ITEM_ATTRIBUTE_WRITER, writer);
		}
		void resetWriter() {
			removeAttribute(ITEM_ATTRIBUTE_WRITER);
		}
		const std::string& getWriter() const {
			return getStrAttr(ITEM_ATTRIBUTE_WRITER);
		}

		void setActionId(uint16_t n) {
			if (n < 100) {
				n = 100;
			}

			setIntAttr(ITEM_ATTRIBUTE_ACTIONID, n);
		}
		uint16_t getActionId() const {
			if (!attributes) {
				return 0;
			}
			return static_cast<uint16_t>(getIntAttr(ITEM_ATTRIBUTE_ACTIONID));
		}

		uint16_t getUniqueId() const {
			if (!attributes) {
				return 0;
			}
			return static_cast<uint16_t>(getIntAttr(ITEM_ATTRIBUTE_UNIQUEID));
		}

		void setCharges(uint16_t n) {
			setIntAttr(ITEM_ATTRIBUTE_CHARGES, n);
		}
		uint16_t getCharges() const {
			if (!attributes) {
				return 0;
			}
			return static_cast<uint16_t>(getIntAttr(ITEM_ATTRIBUTE_CHARGES));
		}

		void setFluidType(uint16_t n) {
			setIntAttr(ITEM_ATTRIBUTE_FLUIDTYPE, n);
		}
		uint16_t getFluidType() const {
			if (!attributes) {
				return 0;
			}
			return static_cast<uint16_t>(getIntAttr(ITEM_ATTRIBUTE_FLUIDTYPE));
		}

		void setOwner(uint32_t owner) {
			setIntAttr(ITEM_ATTRIBUTE_OWNER, owner);
		}
		uint32_t getOwner() const {
			if (!attributes) {
				return 0;
			}
			return getIntAttr(ITEM_ATTRIBUTE_OWNER);
		}

		void setCorpseOwner(uint32_t corpseOwner) {
			setIntAttr(ITEM_ATTRIBUTE_CORPSEOWNER, corpseOwner);
		}
		uint32_t getCorpseOwner() const {
			if (!attributes) {
				return 0;
			}
			return getIntAttr(ITEM_ATTRIBUTE_CORPSEOWNER);
		}

		void setRewardCorpse() {
			setCorpseOwner(static_cast<uint32_t>(std::numeric_limits<int32_t>::max()));
		}
		bool isRewardCorpse() {
			return getCorpseOwner() == static_cast<uint32_t>(std::numeric_limits<int32_t>::max());
		}

		void setDuration(int32_t time) {
			setIntAttr(ITEM_ATTRIBUTE_DURATION, time);
		}
		void decreaseDuration(int32_t time) {
			increaseIntAttr(ITEM_ATTRIBUTE_DURATION, -time);
		}
		uint32_t getDuration() const {
			if (!attributes) {
				return 0;
			}
			return getIntAttr(ITEM_ATTRIBUTE_DURATION);
		}

		void setDecaying(ItemDecayState_t decayState) {
			setIntAttr(ITEM_ATTRIBUTE_DECAYSTATE, decayState);
		}
		ItemDecayState_t getDecaying() const {
			if (!attributes) {
				return DECAYING_FALSE;
			}
			return static_cast<ItemDecayState_t>(getIntAttr(ITEM_ATTRIBUTE_DECAYSTATE));
		}

		static std::string getDescription(const ItemType& it, int32_t lookDistance, const Item* item = nullptr, int32_t subType = -1, bool addArticle = true);
		static std::string getNameDescription(const ItemType& it, const Item* item = nullptr, int32_t subType = -1, bool addArticle = true);
		static std::string getWeightDescription(const ItemType& it, uint32_t weight, uint32_t count = 1);

		std::string getDescription(int32_t lookDistance) const final;
		std::string getNameDescription() const;
		std::string getWeightDescription() const;

		//serialization
		virtual Attr_ReadValue readAttr(AttrTypes_t attr, PropStream& propStream);
		bool unserializeAttr(PropStream& propStream);
		virtual bool unserializeItemNode(OTB::Loader&, const OTB::Node&, PropStream& propStream);

		virtual void serializeAttr(PropWriteStream& propWriteStream) const;

		bool isPushable() const final {
			return isMoveable();
		}
		int32_t getThrowRange() const final {
			return (isPickupable() ? 15 : 2);
		}

		uint16_t getID() const {
			return id;
		}
		uint16_t getClientID() const {
			return items[id].clientId;
		}
		void setID(uint16_t newid);

		// Returns the player that is holding this item in his inventory
		Player* getHoldingPlayer() const;

		WeaponType_t getWeaponType() const {
			return items[id].weaponType;
		}
		Ammo_t getAmmoType() const {
			return items[id].ammoType;
		}
		uint8_t getShootRange() const {
			if (hasAttribute(ITEM_ATTRIBUTE_SHOOTRANGE)) {
				return getIntAttr(ITEM_ATTRIBUTE_SHOOTRANGE);
			}
			return items[id].shootRange;
		}

		virtual uint32_t getWeight() const;
		uint32_t getBaseWeight() const {
			if (hasAttribute(ITEM_ATTRIBUTE_WEIGHT)) {
				return getIntAttr(ITEM_ATTRIBUTE_WEIGHT);
			}
			return items[id].weight;
		}
		int32_t getAttack() const {
			if (hasAttribute(ITEM_ATTRIBUTE_ATTACK)) {
				return getIntAttr(ITEM_ATTRIBUTE_ATTACK);
			}
			return items[id].attack;
		}
		int32_t getArmor() const {
			if (hasAttribute(ITEM_ATTRIBUTE_ARMOR)) {
				return getIntAttr(ITEM_ATTRIBUTE_ARMOR);
			}
			return items[id].armor;
		}
		int32_t getDefense() const {
			if (hasAttribute(ITEM_ATTRIBUTE_DEFENSE)) {
				return getIntAttr(ITEM_ATTRIBUTE_DEFENSE);
			}
			return items[id].defense;
		}
		int32_t getExtraDefense() const {
			if (hasAttribute(ITEM_ATTRIBUTE_EXTRADEFENSE)) {
				return getIntAttr(ITEM_ATTRIBUTE_EXTRADEFENSE);
			}
			return items[id].extraDefense;
		}
		int32_t getImbuingSlots() const {
			if (hasAttribute(ITEM_ATTRIBUTE_IMBUINGSLOTS)) {
				return getIntAttr(ITEM_ATTRIBUTE_IMBUINGSLOTS);
			}
			return items[id].imbuingSlots;
		}
		int32_t getSlotPosition() const {
			return items[id].slotPosition;
		}
		int8_t getHitChance() const {
			if (hasAttribute(ITEM_ATTRIBUTE_HITCHANCE)) {
				return getIntAttr(ITEM_ATTRIBUTE_HITCHANCE);
			}
			return items[id].hitChance;
		}

		uint32_t getWorth() const;
		void getLight(LightInfo& lightInfo) const;

		bool hasProperty(ITEMPROPERTY prop) const;
		bool isBlocking() const {
			return items[id].blockSolid;
		}
		bool isStackable() const {
			return items[id].stackable;
		}
		bool isAlwaysOnTop() const {
			return items[id].alwaysOnTop;
		}
		bool isGroundTile() const {
			return items[id].isGroundTile();
		}
		bool isMagicField() const {
			return items[id].isMagicField();
		}
		bool isMoveable() const {
			return items[id].moveable;
		}
		bool isPickupable() const {
			return items[id].pickupable;
		}
		bool isUseable() const {
			return items[id].useable;
		}
		bool isHangable() const {
			return items[id].isHangable;
		}
		bool isRotatable() const {
			const ItemType& it = items[id];
			return it.rotatable && it.rotateTo;
		}
		bool hasWalkStack() const {
			return items[id].walkStack;
		}
		bool isForceUse() const {
			return items[id].forceUse;
		}

		const std::string& getName() const {
			if (hasAttribute(ITEM_ATTRIBUTE_NAME)) {
				return getStrAttr(ITEM_ATTRIBUTE_NAME);
			}
			return items[id].name;
		}
		const std::string getPluralName() const {
			if (hasAttribute(ITEM_ATTRIBUTE_PLURALNAME)) {
				return getStrAttr(ITEM_ATTRIBUTE_PLURALNAME);
			}
			return items[id].getPluralName();
		}
		const std::string& getArticle() const {
			if (hasAttribute(ITEM_ATTRIBUTE_ARTICLE)) {
				return getStrAttr(ITEM_ATTRIBUTE_ARTICLE);
			}
			return items[id].article;
		}

		// get the number of items
		uint16_t getItemCount() const {
			return count;
		}
		void setItemCount(uint8_t n) {
			count = n;
		}

		
		uint16_t getElemenType() const {
			return elemenType;
		}
		uint16_t getElemenDamage() const {
			return elemenDamage;
		}
		void setElemenType(uint8_t n) {
			elemenType = n;
		}
		void setElemenDamage(uint8_t n) {
			elemenDamage = n;
		}

		
		
		static uint32_t countByType(const Item* i, int32_t subType) {
			if (subType == -1 || subType == i->getSubType()) {
				return i->getItemCount();
			}

			return 0;
		}

		void setDefaultSubtype();
		uint16_t getSubType() const;
		void setSubType(uint16_t n);

		void setUniqueId(uint16_t n);

		void setDefaultDuration() {
			uint32_t duration = getDefaultDuration();
			if (duration != 0) {
				setDuration(duration);
			}
		}
		uint32_t getDefaultDuration() const {
			return items[id].decayTime * 1000;
		}
		bool canDecay() const;

		virtual bool canRemove() const {
			return true;
		}
		virtual bool canTransform() const {
			return true;
		}
		virtual void onRemoved();
		virtual void onTradeEvent(TradeEvents_t, Player*) {}

		virtual void startDecaying();

		bool hasMarketAttributes() const;

		void setLoadedFromMap(bool value) {
			loadedFromMap = value;
		}
		bool isCleanable() const {
			return !loadedFromMap && canRemove() && isPickupable() && !hasAttribute(ITEM_ATTRIBUTE_UNIQUEID) && !hasAttribute(ITEM_ATTRIBUTE_ACTIONID);
		}

		std::unique_ptr<ItemAttributes>& getAttributes() {
			if (!attributes) {
				attributes.reset(new ItemAttributes());
			}
			return attributes;
		}

		void incrementReferenceCounter() {
			++referenceCounter;
		}
		void decrementReferenceCounter() {
			if (--referenceCounter == 0) {
				delete this;
			}
		}

		Cylinder* getParent() const {
			return parent;
		}
		void setParent(Cylinder* cylinder) {
			parent = cylinder;
		}
		Cylinder* getTopParent();
		const Cylinder* getTopParent() const;
		Tile* getTile();
		const Tile* getTile() const;
		bool isRemoved() const {
			return !parent || parent->isRemoved();
		}

	protected:
		std::string getWeightDescription(uint32_t weight) const;

		Cylinder* parent = nullptr;
		std::unique_ptr<ItemAttributes> attributes;

		uint32_t referenceCounter = 0;

		uint16_t id;  // the same id as in ItemType
		uint8_t count = 1; // number of stacked items
		
		uint8_t elemenType = 0;
		uint8_t elemenDamage = 0;

		bool loadedFromMap = false;

		//Don't add variables here, use the ItemAttribute class.
};

using ItemList = std::list<Item*>;
using ItemDeque = std::deque<Item*>;

#endif
