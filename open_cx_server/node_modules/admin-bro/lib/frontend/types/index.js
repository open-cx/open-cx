"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.noticeType = exports.childrenType = exports.matchType = exports.historyType = exports.locationType = exports.recordType = exports.resourceParentWithResourcesType = exports.resourceType = exports.resourceParentType = exports.actionType = exports.simplifiedPropertyType = exports.versionsType = exports.propertyType = exports.brandingType = exports.sessionType = exports.pathsType = void 0;

var _propTypes = _interopRequireDefault(require("prop-types"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const pathsType = _propTypes.default.shape({
  loginPath: _propTypes.default.string.isRequired,
  rootPath: _propTypes.default.string.isRequired,
  logoutPath: _propTypes.default.string.isRequired
});

exports.pathsType = pathsType;

const sessionType = _propTypes.default.shape({
  email: _propTypes.default.string
});

exports.sessionType = sessionType;

const brandingType = _propTypes.default.shape({
  logo: _propTypes.default.string.isRequired,
  companyName: _propTypes.default.string.isRequired,
  softwareBrothers: _propTypes.default.bool.isRequired
});

exports.brandingType = brandingType;
const propertyTypeShape = {
  isId: _propTypes.default.bool.isRequired,
  isSortable: _propTypes.default.bool.isRequired,
  isTitle: _propTypes.default.bool.isRequired,
  label: _propTypes.default.oneOfType([_propTypes.default.string, _propTypes.default.number]).isRequired,
  name: _propTypes.default.oneOfType([_propTypes.default.string, _propTypes.default.number]).isRequired,
  position: _propTypes.default.number.isRequired,
  type: _propTypes.default.string.isRequired,
  availableValues: _propTypes.default.arrayOf(_propTypes.default.shape({
    title: _propTypes.default.string,
    value: _propTypes.default.string
  })),
  reference: _propTypes.default.oneOfType([_propTypes.default.string]),
  isArray: _propTypes.default.boolean
};

const propertyType = _propTypes.default.shape(propertyTypeShape);

exports.propertyType = propertyType;
propertyTypeShape.subProperties = _propTypes.default.arrayOf(propertyType);

const versionsType = _propTypes.default.shape({
  admin: _propTypes.default.string,
  app: _propTypes.default.string
});

exports.versionsType = versionsType;

const simplifiedPropertyType = _propTypes.default.shape({
  isId: _propTypes.default.bool,
  isSortable: _propTypes.default.bool,
  isTitle: _propTypes.default.bool,
  isVisible: _propTypes.default.bool,
  label: _propTypes.default.oneOfType([_propTypes.default.string, _propTypes.default.number]).isRequired,
  name: _propTypes.default.oneOfType([_propTypes.default.string, _propTypes.default.number]).isRequired,
  position: _propTypes.default.number,
  type: _propTypes.default.string,
  availableValues: _propTypes.default.arrayOf(_propTypes.default.shape({
    title: _propTypes.default.string,
    value: _propTypes.default.string
  })),
  reference: _propTypes.default.oneOfType([_propTypes.default.string])
});

exports.simplifiedPropertyType = simplifiedPropertyType;

const actionType = _propTypes.default.shape({
  actionType: _propTypes.default.oneOfType([_propTypes.default.string, _propTypes.default.arrayOf(_propTypes.default.string)]).isRequired,
  icon: _propTypes.default.string,
  label: _propTypes.default.string.isRequired,
  name: _propTypes.default.string.isRequired,
  showFilter: _propTypes.default.bool
});

exports.actionType = actionType;

const resourceParentType = _propTypes.default.shape({
  name: _propTypes.default.string.isRequired,
  icon: _propTypes.default.string.isRequired
});

exports.resourceParentType = resourceParentType;

const resourceType = _propTypes.default.shape({
  editProperties: _propTypes.default.arrayOf(propertyType).isRequired,
  filterProperties: _propTypes.default.arrayOf(propertyType).isRequired,
  href: _propTypes.default.string.isRequired,
  id: _propTypes.default.string.isRequired,
  listProperties: _propTypes.default.arrayOf(propertyType).isRequired,
  name: _propTypes.default.string.isRequired,
  parent: resourceParentType.isRequired,
  resourceActions: _propTypes.default.arrayOf(actionType).isRequired,
  showProperties: _propTypes.default.arrayOf(propertyType).isRequired,
  titleProperty: propertyType.isRequired
});

exports.resourceType = resourceType;

const resourceParentWithResourcesType = _propTypes.default.shape({
  name: _propTypes.default.string.isRequired,
  icon: _propTypes.default.string.isRequired,
  resources: _propTypes.default.arrayOf(resourceType).isRequired
});

exports.resourceParentWithResourcesType = resourceParentWithResourcesType;

const recordType = _propTypes.default.shape({
  params: _propTypes.default.object.isRequired,
  populated: _propTypes.default.object,
  errors: _propTypes.default.object,
  id: _propTypes.default.oneOfType([_propTypes.default.string, _propTypes.default.number]),
  title: _propTypes.default.oneOfType([_propTypes.default.string, _propTypes.default.number]),
  recordActions: _propTypes.default.arrayOf(actionType).isRequired
});

exports.recordType = recordType;

const locationType = _propTypes.default.shape({
  pathname: _propTypes.default.string.isRequired
});

exports.locationType = locationType;

const historyType = _propTypes.default.shape({
  push: _propTypes.default.func.isRequired
});

exports.historyType = historyType;

const matchType = _propTypes.default.shape({
  params: _propTypes.default.shape({
    resourceId: _propTypes.default.string,
    recordId: _propTypes.default.oneOfType([_propTypes.default.string, _propTypes.default.number]),
    actionName: _propTypes.default.string
  })
});

exports.matchType = matchType;

const childrenType = _propTypes.default.oneOfType([_propTypes.default.element, _propTypes.default.arrayOf(_propTypes.default.oneOfType([_propTypes.default.element, _propTypes.default.arrayOf(_propTypes.default.element), _propTypes.default.string, _propTypes.default.number])), _propTypes.default.string, _propTypes.default.number]);

exports.childrenType = childrenType;

const noticeType = _propTypes.default.shape({
  message: _propTypes.default.string,
  progress: _propTypes.default.number,
  type: _propTypes.default.oneOf(['success', 'error'])
});

exports.noticeType = noticeType;