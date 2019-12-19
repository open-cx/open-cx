"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _viewHelpers = _interopRequireDefault(require("../utils/view-helpers"));

var _userComponentsBundler = _interopRequireDefault(require("../bundler/user-components-bundler"));

var _layoutTemplate = _interopRequireDefault(require("../../frontend/layout-template"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/* eslint-disable no-unused-vars */
class AppController {
  constructor({
    admin
  }, currentAdmin) {
    this._admin = admin;
    this.h = new _viewHelpers.default(admin);
    this.currentAdmin = currentAdmin;
  }

  async index() {
    return (0, _layoutTemplate.default)(this._admin, this.currentAdmin, '');
  }

  async resource() {
    return (0, _layoutTemplate.default)(this._admin, this.currentAdmin, '/');
  }

  async resourceAction({
    params
  }) {
    const {
      resourceId,
      actionName
    } = params;
    const href = this.h.resourceActionUrl({
      resourceId,
      actionName
    });
    return (0, _layoutTemplate.default)(this._admin, this.currentAdmin, href);
  }

  async recordAction({
    params
  }) {
    const {
      resourceId,
      actionName,
      recordId
    } = params;

    if (!recordId) {
      throw new Error('you have to give "recordId" in the request parameters');
    }

    const href = this.h.recordActionUrl({
      resourceId,
      actionName,
      recordId
    });
    return (0, _layoutTemplate.default)(this._admin, this.currentAdmin, href);
  }

  async bundleComponents() {
    return (0, _userComponentsBundler.default)(this._admin);
  }

}

exports.default = AppController;