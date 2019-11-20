"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = exports.PARAM_SEPARATOR = void 0;

var flat = _interopRequireWildcard(require("flat"));

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; if (obj != null) { var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

const PARAM_SEPARATOR = '~~';
exports.PARAM_SEPARATOR = PARAM_SEPARATOR;

/**
 * Filter object wrapping up selected filters.
 * @private
 */
class Filter {
  /**
   * Changes raw nested filters to form Object<path, value>.
   *
   * @example
   * const filters = {
   *  nested: {field: 'ala'},
   *  'dataField~~from': '2019-08-14'
   * }
   *
   * const normalized = Filter.normalizeFilters(filters)
   * // {
   * //   'nested.filter': 'ala',
   * //   'dataField': {from: '2019-08-14'}
   * // }
   *
   *
   * @param   {Object}  filters
   *
   * @return  {Object}
   */
  static normalizeKeys(filters) {
    return flat.unflatten(flat.flatten(filters), {
      delimiter: PARAM_SEPARATOR
    });
  }
  /**
   * @param   {Object<String,Object | String>}  filters   selected filters
   * @param   {BaseResource}                    resource    resource which is filtered
   */


  constructor(filters = {}, resource) {
    this.resource = resource;
    const normalized = Filter.normalizeKeys(filters);
    this.filters = Object.keys(normalized).reduce((memo, path) => ({
      [path]: {
        path,
        property: this.resource.property(path),
        value: normalized[path]
      },
      ...memo
    }), {});
  }
  /**
   * Returns filter for a given property key
   *
   * @param {String} key      property key
   * @returns {Filter.Property | undefined}
   */


  get(key) {
    return this.filters[key];
  }
  /**
   * Populates all filtered properties which referes to other resources
   */


  async populate() {
    const keys = Object.keys(this.filters);

    for (let index = 0; index < keys.length; index += 1) {
      const key = keys[index];
      const referenceResource = this.resource.decorate().getPropertyByKey(key).reference();

      if (referenceResource) {
        this.filters[key].populated = await referenceResource.findOne(this.filters[key].value);
      }
    }

    return this;
  }

  reduce(callback, initial) {
    return Object.values(this.filters).reduce(callback, initial || {});
  }

  isVisible() {
    return !!Object.keys(this.filters).length;
  }

}

var _default = Filter;
exports.default = _default;