"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const UserBox = _styledComponents.default.div.attrs({
  className: 'navbar-link'
}).withConfig({
  displayName: "logged-in__UserBox",
  componentId: "sc-1i6tngo-0"
})(["padding-right:", ";border-radius:50px;margin:10px 0;color:", ";img{border-radius:50%;margin-left:", ";&:after{display:none;}}"], ({
  theme
}) => theme.sizes.padding, ({
  theme
}) => theme.colors.lightText, ({
  theme
}) => theme.sizes.padding);

const Dropdown = _styledComponents.default.div.attrs({
  className: 'navbar-dropdown'
}).withConfig({
  displayName: "logged-in__Dropdown",
  componentId: "sc-1i6tngo-1"
})(["border-radius:0px;border:none;padding:0;top:95%;"]);

const LoggedInBox = _styledComponents.default.div.attrs({
  className: 'navbar-item has-dropdown is-hoverable navbar-user'
}).withConfig({
  displayName: "logged-in__LoggedInBox",
  componentId: "sc-1i6tngo-2"
})(["&&&:hover ", "{background-color:", ";color:", ";}&&&:hover ", "{background-color:", ";color:", ";}"], UserBox, ({
  theme
}) => theme.colors.superLightBack, ({
  theme
}) => theme.colors.lightText, Dropdown, ({
  theme
}) => theme.colors.superLightBack, ({
  theme
}) => theme.colors.lightText);

const DropdownLink = _styledComponents.default.a.attrs({
  className: 'navbar-item'
}).withConfig({
  displayName: "logged-in__DropdownLink",
  componentId: "sc-1i6tngo-3"
})(["&&&{padding:", ";color:", ";padding-left:40px;border:none;&:hover{border:4px ", ";padding-left:36px;border-style:none solid;color:", ";background-color:transparent;}i,svg{margin-right:", ";}}"], ({
  theme
}) => `${theme.sizes.padding} ${theme.sizes.paddingLayout}`, ({
  theme
}) => theme.colors.defaultText, ({
  theme
}) => theme.colors.primary, ({
  theme
}) => theme.colors.defaultText, ({
  theme
}) => theme.sizes.padding);

const LoggedIn = props => {
  const {
    session,
    paths
  } = props;
  return _react.default.createElement(LoggedInBox, null, _react.default.createElement(UserBox, null, session.email, _react.default.createElement("img", {
    src: "https://api.adorable.io/avatars/24/softwarebrothers.png",
    alt: "user"
  })), _react.default.createElement(Dropdown, null, _react.default.createElement(DropdownLink, {
    href: paths.logoutPath
  }, _react.default.createElement("i", {
    className: "fas fa-sign-out-alt"
  }), "Sign out")));
};

var _default = LoggedIn;
exports.default = _default;