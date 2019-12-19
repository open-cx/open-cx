"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
Object.defineProperty(exports, "React", {
  enumerable: true,
  get: function () {
    return _react.default;
  }
});
Object.defineProperty(exports, "ReactDOM", {
  enumerable: true,
  get: function () {
    return _reactDom.default;
  }
});
exports.ReactRedux = void 0;

var _react = _interopRequireDefault(require("react"));

var Redux = _interopRequireWildcard(require("redux"));

var _axios = _interopRequireDefault(require("axios"));

var _reactDom = _interopRequireDefault(require("react-dom"));

var ReactRedux = _interopRequireWildcard(require("react-redux"));

exports.ReactRedux = ReactRedux;

var ReactRouter = _interopRequireWildcard(require("react-router"));

var ReactRouterDOM = _interopRequireWildcard(require("react-router-dom"));

var _propTypes = _interopRequireDefault(require("prop-types"));

var styled = _interopRequireWildcard(require("styled-components"));

var Recharts = _interopRequireWildcard(require("recharts"));

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } if (obj === null || typeof obj !== "object" && typeof obj !== "function") { return { default: obj }; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/* eslint-disable import/first, import/no-extraneous-dependencies */
window.global = {};
window.React = _react.default;
window.ReactDOM = _reactDom.default;
window.ReactRedux = ReactRedux;
window.ReactRouter = ReactRouter;
window.ReactRouterDOM = ReactRouterDOM;
window.Redux = Redux;
window.PropTypes = _propTypes.default;
window.axios = _axios.default;
window.styled = styled;
window.Recharts = Recharts;