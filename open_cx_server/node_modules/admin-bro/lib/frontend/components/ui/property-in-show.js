"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

var _label = _interopRequireDefault(require("./label"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const Property = _styledComponents.default.div.withConfig({
  displayName: "property-in-show__Property",
  componentId: "sc-4zsv3b-0"
})(["margin-bottom:", ";"], ({
  theme
}) => theme.sizes.paddingLayout);
/**
 * Wrapps input with label in Show
 *
 * @component
 * @example
 * const property = {
  *   label: 'My amazing property',
  *   name: 'myAmazingProperty',
  * }
  * return (
  *   <WrapperBox border>
  *     <PropertyInShow property={property}>
  *       And here goes a property value.
  *     </PropertyInShow>
  *   </WrapperBox>
  * )
 */


const PropertyInShow = props => {
  const {
    property,
    children
  } = props;
  return _react.default.createElement(Property, null, _react.default.createElement(_label.default, null, property.label), children);
};
/**
 * @memberof PropertyInShow
 */


PropertyInShow.defaultProps = {
  children: null
};
var _default = PropertyInShow;
exports.default = _default;