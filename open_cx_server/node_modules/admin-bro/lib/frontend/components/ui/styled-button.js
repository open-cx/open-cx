"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.styles = exports.default = void 0;

var _styledComponents = _interopRequireWildcard(require("styled-components"));

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; if (obj != null) { var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

const styles = (0, _styledComponents.css)(["&&&{font-size:", ";border-radius:0;border-color:", ";background:", ";height:34px;padding:", ";color:", ";& i,& svg{margin-right:5px;}&:hover{border-color:", ";}&.is-white{background-color:", ";border-color:transparent;color:", ";}&.is-primary{background-color:", ";color:#ffffff;&:hover{background-color:", ";}}&.is-text{background-color:transparent;color:", ";border:transparent;}&.in-dropdown{color:", ";font-size:", ";width:100%;text-align:start;justify-content:flex-start;height:40px;padding-left:40px;border:none;&:hover{border:4px ", ";padding-left:36px;border-style:none solid;}}}"], ({
  theme
}) => theme.fonts.medium, ({
  theme
}) => theme.colors.primary, ({
  theme
}) => theme.colors.bck, ({
  theme
}) => `${theme.sizes.paddingMin} ${theme.sizes.padding}`, ({
  theme
}) => theme.colors.primary, ({
  theme
}) => theme.colors.primaryHover, ({
  theme
}) => theme.colors.bck, ({
  theme
}) => theme.colors.defaultText, ({
  theme
}) => theme.colors.primary, ({
  theme
}) => theme.colors.primaryHover, ({
  theme
}) => theme.colors.primary, ({
  theme
}) => theme.colors.defaultText, ({
  theme
}) => theme.fonts.base, ({
  theme
}) => theme.colors.primary);
/**
 * Base button component
 *
 * @component
 * @example <caption>Regular button</caption>
 * return (
  *   <WrapperBox border>
  *     <StyledButton>I am button</StyledButton>
  *   </WrapperBox>
  * )
  *
  * @example <caption>Primary button</caption>
  * return (
  *   <WrapperBox border>
  *     <StyledButton primary>I am primary button</StyledButton>
  *   </WrapperBox>
  * )
  *
  * @example <caption>With icon</caption>
  * return (
  *   <WrapperBox border>
  *     <StyledButton><i class="fa fa-bomb" />I am button with icon</StyledButton>
  *   </WrapperBox>
  * )
  */

exports.styles = styles;
const StyledButton = (0, _styledComponents.default)('button').attrs(({
  primary
}) => ({
  className: `button${primary ? ' is-primary' : ''}`
})).withConfig({
  displayName: "styled-button__StyledButton",
  componentId: "sc-27o4jb-0"
})(["", ""], styles);
exports.default = StyledButton;