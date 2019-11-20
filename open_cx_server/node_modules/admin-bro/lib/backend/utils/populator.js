"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

/**
 * Populates all records references. If the record has a reference to let say `user_id`
 * it will fill record.populated['user_id'] with the corresponding User record.
 *
 * It mutates the `records` param
 *
 * @param {Array<BaseRecord>} records
 * @param {Array<PropertyDecorator>} [properties] when given it will only populate those properties
 * @private
 */
const populator = async (records, properties) => {
  if (!records || !records.length) {
    return records;
  }

  const allProperties = Object.values(records[0].resource.decorate().properties);
  const populateProperties = properties || allProperties;
  const references = populateProperties.filter(p => !!p.reference());
  await Promise.all(references.map(async propertyDecorator => {
    const referenceResource = propertyDecorator.reference();

    if (!referenceResource) {
      throw new Error([`There is no reference resource named: "${propertyDecorator.property.reference}"`, `for property: "${propertyDecorator.name}"`].join('\n'));
    }

    await referenceResource.populate(records, propertyDecorator.property);
  }));
  return records;
};

var _default = populator;
exports.default = _default;