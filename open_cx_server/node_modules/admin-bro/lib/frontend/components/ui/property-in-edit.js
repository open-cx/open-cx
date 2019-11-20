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
  displayName: "property-in-edit__Property",
  componentId: "sc-1yqxq8u-0"
})(["margin-bottom:", ";& input{border-radius:0;border-color:", ";box-shadow:none;&:focus{border-color:", ";}}& .control > input[type=text]{height:40px;}"], ({
  theme
}) => theme.sizes.paddingLayout, ({
  theme
}) => theme.colors.border, ({
  theme
}) => theme.colors.primary);
/**
 * Wrapps input with label and optional error
 *
 * @component
 * @example <caption>Standard property</caption>
 * const property = {
 *   label: 'My amazing property',
 *   name: 'myAmazingProperty',
 * }
 * const error = { message: 'and there is an error' }
 * return (
 *   <WrapperBox>
 *     <PropertyInEdit property={property} error={error}>
 *       <input className="input" />
 *     </PropertyInEdit>
 *   </WrapperBox>
 * )
 *
 * @example <caption>With an icon</caption>
 * const property = {
 *   label: 'My amazing property',
 *   name: 'myAmazingProperty',
 * }
 * // It is based on the bulma classes
 * return (
 *   <WrapperBox>
 *     <PropertyInEdit property={property}>
 *       <div className="control has-icons-right">
 *         <input className="input" />
 *         <span className="icon is-small is-right">
 *           <i className="fa fa-bomb" />
 *         </span>
 *       </div>
 *     </PropertyInEdit>
 *   </WrapperBox>
 * )
 */


const PropertyInEdit = props => {
  const {
    children,
    property,
    error
  } = props;
  return _react.default.createElement(Property, null, _react.default.createElement(_label.default, {
    htmlFor: property.name
  }, property.label), _react.default.createElement("div", {
    className: "control"
  }, children), error && _react.default.createElement("div", {
    className: "help is-danger"
  }, error.message));
};
/**
 * @memberof PropertyInEdit
 */


var _default = PropertyInEdit;
exports.default = _default;