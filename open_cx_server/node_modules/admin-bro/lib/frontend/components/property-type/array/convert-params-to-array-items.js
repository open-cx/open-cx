"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var flat = _interopRequireWildcard(require("flat"));

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; if (obj != null) { var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

/**
 * Converts flatten params to array items when given property is an array.
 *
 * What problem it solves:
 * so let say user has a record with record.property:
 * ```
 * Item.0.imageVariants.0.dateCreated: "2019-09-19T10:00:00.000Z"
 * Item.0.imageVariants.0.imageURL: "url to help"
 * Item.0.imageVariants.0.isApproved: true
 * Item.0.imageVariants.0.isDeleted: false
 * Item.0.imageVariants.1.dateCreated: "2019-09-19T19:10:34.919Z"
 * Item.0.imageVariants.1.imageURL: "url 2"
 * ```
 *
 * this function for property: `Item.0.imageVariants` should return array with 2 items. Where for
 * property `Item` array with one element
 *
 * @param {PropertyJSON} property
 * @param {RecordJSON} record
 *
 * @private
 */
const convertParamsToArrayItems = (property, record) => {
  const tempName = 'arrayField';
  const regex = new RegExp(`^${property.name}`);
  /**
   * in this step we filter keys which starts with regex the same as name. So let say
   * property name is: Item.0.imageVariants and the record.params is:
   * {
   *  'anyOtherKey': 'value'
   *  'Item.0.imageVariants.0.dateCreated': '2019-09-19T10:00:00.000Z',
   *  'Item.0.imageVariants.0.imageURL': 'url to help'
   * }
   *
   * so keys will be `Item.0.imageVariants.0.dateCreated` and `Item.0.imageVariants.0.imageURL`
   */

  const keys = Object.keys(record.params).filter(key => key.match(regex));
  /**
   * Next, we create new object with only those keys. But we have to rename the regex part
   * because it could has dots (take a look at const tempName = 'arrayField' on the top).
   * If we didn't do this - then unflatten function wouldn't work.
   *
   * so in our example obj is not: {
   *  'Item.0.imageVariants.0.dateCreated': '2019-09-19T10:00:00.000Z',
   *  'Item.0.imageVariants.0.imageURL': 'url to help'
   * }
   *
   * but: {
   *  'arrayField.0.dateCreated': '2019-09-19T10:00:00.000Z',
   *  'arrayField.0.imageURL': 'url to help'
   * }
   */

  const obj = keys.reduce((memo, key) => ({ ...memo,
    [key.replace(regex, tempName)]: record.params[key]
  }), {});
  /**
   * In the last step we unflatten the object and return 'tempName' property:
   * {
   *  'arrayField: [{
   *     dateCreated': '2019-09-19T10:00:00.000Z',
   *     'arrayField.0.imageURL': 'url to help',
   *   }],
   * }['arrayField']
   */

  const unflatten = flat.unflatten(obj);
  return unflatten[tempName] || [];
};

var _default = convertParamsToArrayItems;
exports.default = _default;