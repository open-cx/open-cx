"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const StyledWrapperBox = _styledComponents.default.section.withConfig({
  displayName: "wrapper-box__StyledWrapperBox",
  componentId: "sc-9mf060-0"
})(["padding:", ";color:", ";flex-grow:1;border:", ";background:", ";& > h1{font-size:22px;margin-top:", ";margin-bottom:", ";}"], ({
  theme
}) => theme.sizes.paddingLayout, ({
  theme
}) => theme.colors.defaultText, props => props.border ? `1px solid ${props.theme.colors.border}` : 'none', props => props.border ? props.theme.colors.bck : 'transparent', ({
  theme
}) => theme.sizes.padding, ({
  theme
}) => theme.sizes.padding);
/**
 * Basic layout element which controls padding.
 *
 * @component
 * @example
 * return (
 *   <WrapperBox border>
 *     <h1>Header</h1>
 *     <p>Some inside content</p>
 *   </WrapperBox>
 * )
 */


const WrapperBox = props => _react.default.createElement(StyledWrapperBox, props);
/**
 * @memberof WrapperBox
 */


var _default = WrapperBox;
exports.default = _default;