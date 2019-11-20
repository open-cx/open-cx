"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const Wrapper = _styledComponents.default.section.attrs({
  className: 'content'
}).withConfig({
  displayName: "dashboard-header__Wrapper",
  componentId: "sc-1rc8e45-0"
})(["&&{padding:90px ", ";background:", ";color:#fff;margin-bottom:0;& > *{color:#fff;}p{color:#fff;}h1{color:#fff;font-size:53px;margin-bottom:4px;}}"], ({
  theme
}) => theme.sizes.paddingLayout, ({
  theme
}) => theme.colors.superDarkBck);
/**
 * Component which can be used as the outstanding header of the dashboard page.
 *
 * @component
 * @example <caption>Empty Header with simple text</caption>
 * return (
 *  <DashboardHeader>
 *    <h1>Some text inside a header</h1>
 *    <p>Subtitle</p>
 *  </DashboardHeader>
 * )
 *
 * @example <caption>Header with overlay blocks</caption>
 * return (
 *   <div>
 *     <DashboardHeader>
 *       <h1>Overlaying text</h1>
 *     </DashboardHeader>
 *     <WrapperBox>
 *       <Columns style={{marginTop: '-80px'}}>
 *         <Column><ValueBlock  icon="fa fa-bomb" value="5">
 *           Utils
 *         </ValueBlock></Column>
 *         <Column><ValueBlock  icon="fa fa-star" value="12">
 *           Are
 *         </ValueBlock></Column>
 *         <Column><ValueBlock  icon="fa fa-cog" value="5" color="red">
 *           Awesome
 *         </ValueBlock></Column>
 *       </Columns>
 *     </WrapperBox>
 *   </div>
 * )
 */


const DashboardHeader = props => {
  const {
    children
  } = props;
  return _react.default.createElement(Wrapper, null, children);
};
/**
 * @memberof DashboardHeader
 */


var _default = DashboardHeader;
exports.default = _default;