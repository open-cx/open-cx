"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = updateParamsArray;

var _flat = require("flat");

/**
 * for given params:
 *
 * example:
 * ```
 * anotherItem: 'value'
 * Item.0.imageVariants.0.dateCreated: "2019-09-19T10:00:00.000Z"
 * Item.0.imageVariants.0.imageURL: "url to help"
 * Item.0.imageVariants.0.isApproved: true
 * Item.0.imageVariants.0.isDeleted: false
 * Item.0.imageVariants.1.dateCreated: "2019-09-19T19:10:34.919Z"
 * Item.0.imageVariants.1.imageURL: "url 2"
 * ```
 *
 * and given propertyPath, example: `Item.0.imageVariants`
 * and new array, example: [{
 *   dateCreated: "2019-09-19T19:10:34.919Z"
 *   imageURL: "url 2"
 * }]
 *
 * returns:
 * ```
 * anotherItem: 'value'
 * Item.0.imageVariants.1.dateCreated: "2019-09-19T19:10:34.919Z"
 * Item.0.imageVariants.1.imageURL: "url 2"
 * ```
 *
 * @private
 */
function updateParamsArray(params, propertyPath, array) {
  const regex = new RegExp(`^${propertyPath}`);
  const filteredParams = Object.entries(params).filter(([key]) => !key.match(regex)).reduce((memo, [key, value]) => ({ ...memo,
    [key]: value
  }), {});
  return (0, _flat.flatten)({ ...filteredParams,
    [propertyPath]: array
  });
}