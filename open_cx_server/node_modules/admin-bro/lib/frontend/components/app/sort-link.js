"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

var _reactRouterDom = require("react-router-dom");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const StyledLink = (0, _styledComponents.default)(_reactRouterDom.NavLink).attrs({
  className: 'is-sortable text-small'
}).withConfig({
  displayName: "sort-link__StyledLink",
  componentId: "sc-1iy20ff-0"
})(["color:", ";&.active{color:", ";}& > i{margin-left:", "}"], ({
  theme
}) => theme.colors.lightText, ({
  theme
}) => theme.colors.primary, ({
  theme
}) => theme.sizes.padding);

class SortLink extends _react.default.PureComponent {
  constructor(props) {
    super(props);
    this.isActive = this.isActive.bind(this);
  }

  isActive() {
    const {
      sortBy,
      property
    } = this.props;
    return sortBy === property.name;
  }

  render() {
    const {
      property,
      location,
      direction
    } = this.props;
    const query = new URLSearchParams(location.search);
    const opositeDirection = this.isActive() && direction === 'asc' ? 'desc' : 'asc';
    const sortedByClass = `icomoon-dropdown-${direction === 'asc' ? 'open' : 'close'}`;
    query.set('direction', opositeDirection);
    query.set('sortBy', property.name);
    return _react.default.createElement(StyledLink, {
      to: {
        search: query.toString()
      },
      isActive: this.isActive
    }, property.label, this.isActive() ? _react.default.createElement("i", {
      className: sortedByClass
    }) : '');
  }

}

var _default = (0, _reactRouterDom.withRouter)(SortLink);

exports.default = _default;