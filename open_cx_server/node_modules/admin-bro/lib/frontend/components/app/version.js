"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

var _label = _interopRequireDefault(require("../ui/label"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const VersionWrapper = _styledComponents.default.div.withConfig({
  displayName: "version__VersionWrapper",
  componentId: "rgspw3-0"
})(["padding:10px 0;"]);

const VersionBlock = _styledComponents.default.p.withConfig({
  displayName: "version__VersionBlock",
  componentId: "rgspw3-1"
})(["&&&{& > label{display:inline;}}"]);

const Version = props => {
  const {
    versions
  } = props;
  const {
    admin,
    app
  } = versions;
  return _react.default.createElement(VersionWrapper, null, admin && _react.default.createElement(VersionBlock, null, _react.default.createElement(_label.default, null, "admin:"), admin), app && _react.default.createElement(VersionBlock, null, _react.default.createElement(_label.default, null, "app:"), app));
};

var _default = Version;
exports.default = _default;