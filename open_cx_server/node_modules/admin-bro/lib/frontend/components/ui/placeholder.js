"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const StyledPlaceholder = _styledComponents.default.div.withConfig({
  displayName: "placeholder__StyledPlaceholder",
  componentId: "sc-1cbjegf-0"
})(["@keyframes placeHolderShimmer{0%{background-position:-468px 0}100%{background-position:468px 0}}animation-duration:1s;animation-fill-mode:forwards;animation-iteration-count:infinite;animation-name:placeHolderShimmer;animation-timing-function:linear;background:#f6f7f8;background:linear-gradient(to right,#eeeeee 8%,#dddddd 18%,#eeeeee 33%);background-size:1000px 104px;height:338px;position:relative;overflow:hidden;"]);
/**
 * Renders placeholder
 * @component
 *
 * @example <caption>Image placeholder</caption>
 * return (
 *   <WrapperBox border>
 *     <Placeholder style={{ width: 100, height: 200 }} />
 *   </WrapperBox>
 * )
 *
 * @example <caption>Text placeholder</caption>
 * return (
 *   <WrapperBox border>
 *     <Label>Some name</Label>
 *     <Placeholder style={{ width: 400, height: 14 }} />
 *   </WrapperBox>
 * )
 */


const Placeholder = props => _react.default.createElement(StyledPlaceholder, props);
/**
 * @memberof Placeholder
 */


var _default = Placeholder;
exports.default = _default;