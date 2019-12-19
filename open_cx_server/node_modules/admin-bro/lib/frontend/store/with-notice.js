"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _reactRedux = require("react-redux");

var _store = require("./store");

const mapDispatchToProps = dispatch => ({
  addNotice: notice => dispatch((0, _store.addNotice)(notice))
});

const withNotice = Component => (0, _reactRedux.connect)(null, mapDispatchToProps)(Component);

var _default = withNotice;
exports.default = _default;