"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

var _ui = require("../ui");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const DashboardWrapper = _styledComponents.default.section.withConfig({
  displayName: "default-dashboard__DashboardWrapper",
  componentId: "y6jxa9-0"
})(["display:flex;flex-grow:1;align-items:center;justify-content:center;padding:", ";"], ({
  theme
}) => theme.sizes.padding);

const InfoBox = _styledComponents.default.section.attrs({
  className: 'content'
}).withConfig({
  displayName: "default-dashboard__InfoBox",
  componentId: "y6jxa9-1"
})(["width:540px;"]);

const SoftwareBrothers = _styledComponents.default.div.withConfig({
  displayName: "default-dashboard__SoftwareBrothers",
  componentId: "y6jxa9-2"
})(["padding:10px 0;border-top:1px solid ", ";img{float:left;padding:10px 15px 10px 0;width:140px;}a{color:", ";}"], ({
  theme
}) => theme.colors.love, ({
  theme
}) => theme.colors.love);

const Dashboard = () => _react.default.createElement(DashboardWrapper, null, _react.default.createElement(InfoBox, null, _react.default.createElement("h1", null, "Welcome on board!"), _react.default.createElement("p", null, "Thank you for trying out", _react.default.createElement("b", null, " AdminBro.")), _react.default.createElement("p", null, "Next, you might want to check out the following tutorials:"), _react.default.createElement(_ui.Columns, null, _react.default.createElement(_ui.Column, {
  width: 6
}, _react.default.createElement("ul", null, _react.default.createElement("li", null, _react.default.createElement("a", {
  href: "https://softwarebrothers.github.io/admin-bro-dev/tutorial-03-passing-resources.html"
}, "Adding Resources")), _react.default.createElement("li", null, _react.default.createElement("a", {
  href: "https://softwarebrothers.github.io/admin-bro-dev/tutorial-04-customizing-resources.html"
}, "Customising resources")), _react.default.createElement("li", null, _react.default.createElement("a", {
  href: "https://softwarebrothers.github.io/admin-bro-dev/tutorial-05-actions.html"
}, "Customising Actions")))), _react.default.createElement(_ui.Column, {
  width: 6
}, _react.default.createElement("ul", null, _react.default.createElement("li", null, _react.default.createElement("a", {
  href: "https://softwarebrothers.github.io/admin-bro-dev/tutorial-06-writing-react-components.html"
}, "Writing your own components")), _react.default.createElement("li", null, _react.default.createElement("a", {
  href: "https://softwarebrothers.github.io/admin-bro-dev/tutorial-07-custom-dashboard.html"
}, "Customising Dashboard"))))), _react.default.createElement("p", null, "In case you found any errors,", _react.default.createElement("a", {
  href: "https://github.com/SoftwareBrothers/admin-bro/issues"
}, " raise an issue "), "on our GitHub account."), _react.default.createElement("p", null, "For the latest information about AdminBro and more -", _react.default.createElement("a", {
  href: "https://softwarebrothers.co/blog/"
}, " check out our blog.")), _react.default.createElement(SoftwareBrothers, null, _react.default.createElement("img", {
  src: "https://softwarebrothers.co/assets/images/software-brothers-logo-full.svg",
  alt: "SoftwareBrothers"
}), _react.default.createElement("p", null, "Want to add advanced fields like Google Maps, enrich interface with custom graphs or simply look for professional help? You can always", _react.default.createElement("a", {
  href: "https://softwarebrothers.co/services"
}, " work with us!")))));

var _default = Dashboard;
exports.default = _default;