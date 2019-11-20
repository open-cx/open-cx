"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _configurationError = _interopRequireDefault(require("../utils/configuration-error"));

var _viewHelpers = _interopRequireDefault(require("../utils/view-helpers"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/**
 * Decorates an action
 *
 * @category Decorators
 */
class ActionDecorator {
  /**
   * @param {Object}        params
   * @param {Action}    params.action
   * @param {BaseResource}  params.resource
   * @param {AdminBro}      params.admin  current instance of AdminBro
   */
  constructor({
    action,
    admin,
    resource
  }) {
    if (!action.actionType) {
      throw new _configurationError.default(`action: "${action.name}" does not have an "actionType" property`, 'Action');
    }

    this.name = action.name;
    this._admin = admin;
    this._resource = resource;
    this.h = new _viewHelpers.default({
      options: admin.options
    });
    /**
     * Original action object
     * @type {Action}
     */

    this.action = action;
  }
  /**
   * Original handler wrapped with the hook `before` and `after` methods.
   *
   * @param {ActionRequest} request
   * @param {any} response
   * @param {ActionContext} data
   *
   * @return {Promise<any>}
   */


  async handler(request, response, data) {
    let modifiedRequest = request;

    if (typeof this.action.before === 'function') {
      modifiedRequest = await this.action.before(request, data);
    }

    let ret = await this.action.handler(modifiedRequest, response, data);

    if (typeof this.action.after === 'function') {
      ret = await this.action.after(ret, modifiedRequest, data);
    }

    return ret;
  }
  /**
   * Returns true when action can be performed on a record
   *
   * @return  {Boolean}
   */


  isRecordType() {
    return this.action.actionType.includes('record');
  }
  /**
   * Returns true when action can be performed on an entire resource
   *
   * @return  {Boolean}
   */


  isResourceType() {
    return this.action.actionType.includes('resource');
  }

  is(what, currentAdmin, record) {
    if (!['isAccessible', 'isVisible'].includes(what)) {
      throw new Error(`'what' has to be either "isAccessible" or "isVisible". You gave ${what}`);
    }

    let isAction;

    if (typeof this.action[what] === 'function') {
      isAction = this.action[what]({
        resource: this._resource,
        record,
        action: this,
        h: this.h,
        currentAdmin,
        _admin: this._admin
      });
    } else if (typeof this.action[what] === 'undefined') {
      isAction = true;
    } else {
      isAction = this.action[what];
    }

    return isAction;
  }
  /**
   * Is action visible in the UI
   * @param {CurrentAdmin} [currentAdmin]   currently logged in admin user
   * @param {BaseRecord} [record]
   *
   * @return  {Boolean}
   */


  isVisible(currentAdmin, record) {
    return this.is('isVisible', currentAdmin, record);
  }
  /**
   * Is action accessible
   *
   * @param {CurrentAdmin} [currentAdmin]   currently logged in admin user
   * @param {BaseRecord} [record]
   * @return  {Boolean}
   */


  isAccessible(currentAdmin, record) {
    return this.is('isAccessible', currentAdmin, record);
  }
  /**
   * Serializes action to JSON format
   *
   * @return  {ActionJSON}  serialized action
   */


  toJSON() {
    return {
      name: this.action.name,
      actionType: this.action.actionType,
      icon: this.action.icon,
      label: this.action.label || this.action.name,
      guard: this.action.guard,
      showFilter: !!this.action.showFilter,
      component: this.action.component
    };
  }

}

var _default = ActionDecorator;
exports.default = _default;