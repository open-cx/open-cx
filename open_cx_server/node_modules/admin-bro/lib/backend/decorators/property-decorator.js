"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _ = _interopRequireWildcard(require("lodash"));

var _propertyOptions = require("./property-options.interface");

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; if (obj != null) { var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

/**
 * Decorates property
 *
 * @category Decorators
 */
class PropertyDecorator {
  /**
   * @param {Object} opts
   * @param {BaseProperty}        opts.property
   * @param  {AdminBro}           opts.admin  current instance of AdminBro
   * @param {PropertyOptions}     opts.options
   * @param {ResourceDecorator}   opts.resource
   */
  constructor({
    property,
    admin,
    options = {},
    resource
  }) {
    this.property = property;
    this._admin = admin;
    this._resource = resource;
    /**
     * Options passed along with a given resource
     * @type {PropertyOptions}
    */

    this.options = options;
  }
  /**
   * True if given property can be sortable
   *
   * @returns {boolean}
   */


  isSortable() {
    return this.property.isSortable();
  }

  overrideFromOptions(optionName, defaultValue) {
    if (typeof this.options[optionName] === 'undefined') {
      if (defaultValue) {
        return defaultValue();
      }

      return this.property[optionName]();
    }

    return this.options[optionName];
  }
  /**
   * When given property is a reference to another Resource - it returns this Resource
   *
   * @return  {BaseResource} reference resource
   */


  reference() {
    const referenceResourceId = this.property.reference();

    if (referenceResourceId) {
      const resource = this._admin.findResource(referenceResourceId);

      return resource;
    }

    return null;
  }
  /**
   * Name of the property
   *
   * @returns {string}
   */


  name() {
    return this.overrideFromOptions(_propertyOptions.AvailablePropertyOptions.name);
  }
  /**
   * Label of a property
   *
   * @return  {string}
   */


  label() {
    return this.overrideFromOptions(_propertyOptions.AvailablePropertyOptions.label, () => _.startCase(this.property.name()));
  }
  /**
   * Property type
   *
   * @returns {PropertyType}
   */


  type() {
    return this.overrideFromOptions(_propertyOptions.AvailablePropertyOptions.type);
  }
  /**
   * If given property has limited number of available values
   * it returns them.
   *
   * @returns {Array<{value: string, label: string}>}
   */


  availableValues() {
    return this.overrideFromOptions(_propertyOptions.AvailablePropertyOptions.availableValues, () => {
      const values = this.property.availableValues();

      if (values) {
        return values.map(val => ({
          value: val,
          label: val
        }));
      }

      return null;
    });
  }
  /**
   * Indicates if given property should be visible
   *
   * @param {boolean} element      it could be either "list", "edit" or "show"
   */


  isVisible(element) {
    if (typeof this.options.isVisible === 'object') {
      return this.options.isVisible[element];
    }

    if (typeof this.options.isVisible === 'boolean') {
      return this.options.isVisible;
    }

    if (element === 'edit') {
      return this.property.isEditable();
    }

    return this.property.isVisible();
  } // TODO: add option to pass function to isVisible

  /**
   * Position of the field
   *
   * @return {number}
   */


  position() {
    return this.overrideFromOptions(_propertyOptions.AvailablePropertyOptions.position, () => {
      if (this.isTitle()) {
        return -1;
      }

      if (this.isId()) {
        return 0;
      }

      return 100;
    });
  }
  /**
   * If property should be treated as an ID field
   *
   * @return {boolean}
   */


  isId() {
    return !!this.overrideFromOptions(_propertyOptions.AvailablePropertyOptions.isId);
  }
  /**
   * If property should be treated as an title field
   * Title field is used as a link to the resource page
   * in the list view and in the breadcrumbs
   *
   * @return {boolean}
   */


  isTitle() {
    return !!this.overrideFromOptions(_propertyOptions.AvailablePropertyOptions.isTitle);
  }
  /**
   * Returns JSON representation of a property
   *
   * @return {PropertyJSON}
   */


  toJSON() {
    return {
      isTitle: this.isTitle(),
      isId: this.isId(),
      position: this.position(),
      isSortable: this.isSortable(),
      availableValues: this.availableValues(),
      name: this.name(),
      label: this.label(),
      type: this.type(),
      reference: this.property.reference(),
      components: this.options.components,
      subProperties: this.property.subProperties().map(subProperty => {
        const optionKey = `${this.property.name()}.${subProperty.name()}`;
        const decorated = new PropertyDecorator({
          property: subProperty,
          admin: this._admin,
          options: this._resource.options && this._resource.options.properties && this._resource.options.properties[optionKey],
          resource: this._resource
        });
        return decorated.toJSON();
      }),
      isArray: this.property.isArray()
    };
  }

}

var _default = PropertyDecorator;
exports.default = _default;