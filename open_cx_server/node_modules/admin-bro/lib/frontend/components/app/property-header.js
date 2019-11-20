"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

var _sortLink = _interopRequireDefault(require("./sort-link"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const Th = _styledComponents.default.th.withConfig({
  displayName: "property-header__Th",
  componentId: "uxn6b8-0"
})(["&&&{font-size:", ";text-transform:uppercase;color:", ";font-weight:normal;padding:", ";letter-spacing:0.1em;border:none;}"], ({
  theme
}) => theme.fonts.min, ({
  theme
}) => theme.colors.lightText, ({
  theme
}) => theme.sizes.padding);

const PropertyHeader = props => {
  const {
    property,
    titleProperty
  } = props;
  const isMain = property.name === titleProperty.name;
  return _react.default.createElement(Th, {
    className: isMain ? 'main' : undefined
  }, property.isSortable ? _react.default.createElement(_sortLink.default, props) : property.label);
};

var _default = PropertyHeader;
exports.default = _default;