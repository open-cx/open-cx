"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _styledComponents = _interopRequireDefault(require("styled-components"));

var _reactRouterDom = require("react-router-dom");

var _styledButton = require("./styled-button");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/**
 * Component wrapping Link from React Router with styled. It looks exactly like {@link StyledButton}
 *
 * @see https://github.com/ReactTraining/react-router/blob/master/packages/react-router-dom/docs/api/Link.md
 * @component
*/
const StyledLink = (0, _styledComponents.default)(_reactRouterDom.Link).attrs(({
  primary
}) => ({
  className: `button${primary ? ' is-primary' : ''}`
})).withConfig({
  displayName: "styled-link__StyledLink",
  componentId: "sc-1csyv7l-0"
})(["", ""], _styledButton.styles);
var _default = StyledLink;
exports.default = _default;