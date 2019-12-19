"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _styledComponents = _interopRequireDefault(require("styled-components"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/**
 * Simple compnent for styling tables
 *
 * @component
 * @example
 * return (
 * <WrapperBox border>
 *   <h1>Table Information</h1>
 *   <Table>
 *     <thead>
 *       <tr>
 *         <th><Label>Label1</Label></th>
 *         <th><Label>Label2</Label></th>
 *       </tr>
 *     </thead>
 *     <tbody>
 *       <tr>
 *         <td>Value1</td>
 *         <td>Value12</td>
 *       </tr>
 *       <tr>
 *         <td>Value1</td>
 *         <td>Value12</td>
 *       </tr>
 *     </tbody>
 *   </Table>
 * </WrapperBox>
 * )
 */
const Table = _styledComponents.default.table.attrs({
  className: 'table is-fullwidth'
}).withConfig({
  displayName: "table__Table",
  componentId: "sc-8urxmk-0"
})(["background:transparent;& > thead > tr > th{border:none;}& tr.is-selected{background:", ";}& tr:hover{background:", ";}td{color:", ";padding:", ";border-color:", ";}"], ({
  theme
}) => theme.colors.primary, ({
  theme
}) => theme.colors.superLightBack, ({
  theme
}) => theme.colors.defaultText, ({
  theme
}) => theme.sizes.padding, ({
  theme
}) => theme.colors.border);

var _default = Table;
exports.default = _default;