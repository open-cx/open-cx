"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

var _wrapperBox = _interopRequireDefault(require("./wrapper-box"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const Spinner = _styledComponents.default.div.attrs({
  className: 'lds-facebook'
}).withConfig({
  displayName: "loader__Spinner",
  componentId: "sc-103tj8g-0"
})(["&{display:inline-block;position:relative;width:64px;height:64px;}& div{display:inline-block;position:absolute;left:6px;width:13px;background:", ";animation:lds-facebook 1.2s cubic-bezier(0,0.5,0.5,1) infinite;}& div:nth-child(1){left:6px;animation-delay:-0.24s;}& div:nth-child(2){left:26px;animation-delay:-0.12s;}& div:nth-child(3){left:45px;animation-delay:0;}@keyframes lds-facebook{0%{top:6px;height:51px;}50%,100%{top:19px;height:26px;}}"], ({
  theme
}) => theme.colors.primary);
/**
 * Simple loader
 *
 * @component
 * @example
 * return (
 *   <WrapperBox border><Loader/></WrapperBox>
 * )
 */


const Loader = () => _react.default.createElement(_wrapperBox.default, {
  style: {
    textAlign: 'center'
  }
}, _react.default.createElement(Spinner, null, _react.default.createElement("div", null), _react.default.createElement("div", null), _react.default.createElement("div", null)));

var _default = Loader;
exports.default = _default;