"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _styledComponents = _interopRequireDefault(require("styled-components"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/**
 * Marks group of fields as a section
 *
 * @component
 *
 * @example
 * const property = {
 *   label: 'My amazing property',
 *   name: 'myAmazingProperty',
 * }
 * return (
 * <StyledSection>
 *  <PropertyInEdit property={property}>
 *    <input className="input" />
 *  </PropertyInEdit>
 *  <p>
 *    <StyledButton>
 *      Add new item in section
 *    </StyledButton>
 *  </p>
 * </StyledSection>
 * )
 */
const StyledSection = _styledComponents.default.section.withConfig({
  displayName: "styled-section__StyledSection",
  componentId: "sc-16m82m4-0"
})(["border-left:", " solid ", ";padding-left:", ";"], ({
  theme
}) => theme.sizes.paddingMin, ({
  theme
}) => theme.colors.lightBck, ({
  theme
}) => theme.sizes.padding);

var _default = StyledSection;
exports.default = _default;