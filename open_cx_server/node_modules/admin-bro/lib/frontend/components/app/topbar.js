"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactRedux = require("react-redux");

var _styledComponents = _interopRequireDefault(require("styled-components"));

var _loggedIn = _interopRequireDefault(require("./logged-in"));

var _version = _interopRequireDefault(require("./version"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const Navbar = _styledComponents.default.nav.attrs({
  className: 'navbar'
}).withConfig({
  displayName: "topbar__Navbar",
  componentId: "zvd2d6-0"
})(["height:", ";border-bottom:1px solid ", ";padding:0 ", ";flex-shrink:0;background:", ";"], ({
  theme
}) => theme.sizes.navbarHeight, ({
  theme
}) => theme.colors.border, ({
  theme
}) => theme.sizes.paddingLayout, ({
  theme
}) => theme.colors.bck);

const Topbar = props => {
  const {
    session,
    versions,
    paths
  } = props;
  return _react.default.createElement(Navbar, null, _react.default.createElement("div", {
    className: "navbar-menu"
  }, _react.default.createElement("div", {
    className: "navbar-start"
  }, _react.default.createElement(_version.default, {
    versions: versions
  })), _react.default.createElement("div", {
    className: "navbar-end"
  }, session && session.email ? _react.default.createElement(_loggedIn.default, {
    session: session,
    paths: paths
  }) : '')));
};

const mapStateToProps = state => ({
  session: state.session,
  paths: {
    logoutPath: state.paths.logoutPath
  },
  versions: state.versions
});

var _default = (0, _reactRedux.connect)(mapStateToProps)(Topbar);

exports.default = _default;