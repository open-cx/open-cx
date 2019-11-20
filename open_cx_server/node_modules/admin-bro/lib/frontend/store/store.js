"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = exports.dropNotice = exports.setNoticeProgress = exports.addNotice = exports.NoticeType = exports.initializeSession = exports.initializeVersions = exports.initializePaths = exports.initializeBranding = exports.initializeDashboard = exports.initializeResources = void 0;

var _redux = require("redux");

var _constants = require("../../constants");

/* eslint-disable @typescript-eslint/explicit-function-return-type */
const initializeResources = data => ({
  type: 'RESOURCES_INITIALIZE',
  data
});

exports.initializeResources = initializeResources;

const initializeDashboard = data => ({
  type: 'DASHBOARD_INITIALIZE',
  data
});

exports.initializeDashboard = initializeDashboard;

const initializeBranding = data => ({
  type: 'BRANDING_INITIALIZE',
  data
});

exports.initializeBranding = initializeBranding;

const initializePaths = data => ({
  type: 'PATHS_INITIALIZE',
  data
});

exports.initializePaths = initializePaths;

const initializeVersions = data => ({
  type: 'VERSIONS_INITIALIZE',
  data
});

exports.initializeVersions = initializeVersions;

const initializeSession = (data = {}) => ({
  type: 'SESSION_INITIALIZE',
  data
});

exports.initializeSession = initializeSession;
let NoticeType;
exports.NoticeType = NoticeType;

(function (NoticeType) {
  NoticeType["success"] = "success";
  NoticeType["error"] = "error";
})(NoticeType || (exports.NoticeType = NoticeType = {}));

const addNotice = (data = {
  message: ''
}) => ({
  type: 'ADD_NOTICE',
  data: {
    message: data.message,
    id: Math.random().toString(36).substr(2, 9),
    type: data.type || NoticeType.success,
    progress: 0
  }
});

exports.addNotice = addNotice;

const setNoticeProgress = ({
  noticeId,
  progress
}) => ({
  type: 'SET_NOTICE_PROGRESS',
  data: {
    noticeId,
    progress
  }
});

exports.setNoticeProgress = setNoticeProgress;

const dropNotice = noticeId => ({
  type: 'DROP_NOTICE',
  data: {
    noticeId
  }
});

exports.dropNotice = dropNotice;

const resourcesReducer = (state = [], action) => {
  switch (action.type) {
    case 'RESOURCES_INITIALIZE':
      return action.data;

    default:
      return state;
  }
};

const brandingReducer = (state = {}, action) => {
  switch (action.type) {
    case 'BRANDING_INITIALIZE':
      return action.data;

    default:
      return state;
  }
};

const pathsReducer = (state = _constants.DEFAULT_PATHS, action) => {
  switch (action.type) {
    case 'PATHS_INITIALIZE':
      return action.data;

    default:
      return state;
  }
};

const dashboardReducer = (state = {}, action) => {
  switch (action.type) {
    case 'DASHBOARD_INITIALIZE':
      return action.data;

    default:
      return state;
  }
};

const sessionReducer = (state = null, action) => {
  switch (action.type) {
    case 'SESSION_INITIALIZE':
      return action.data;

    default:
      return state;
  }
};

const versionsReducer = (state = {}, action) => {
  switch (action.type) {
    case 'VERSIONS_INITIALIZE':
      return {
        admin: action.data.admin,
        app: action.data.app
      };

    default:
      return state;
  }
};

const noticesReducer = (state = [], action) => {
  switch (action.type) {
    case 'ADD_NOTICE':
      {
        const notices = [action.data];
        return notices;
      }

    case 'DROP_NOTICE':
      {
        return state.filter(notice => notice.id !== action.data.noticeId);
      }

    case 'SET_NOTICE_PROGRESS':
      {
        return state.map(notice => ({ ...notice,
          progress: notice.id === action.data.noticeId ? action.data.progress : notice.progress
        }));
      }

    default:
      return state;
  }
};

const reducer = (0, _redux.combineReducers)({
  resources: resourcesReducer,
  branding: brandingReducer,
  paths: pathsReducer,
  session: sessionReducer,
  dashboard: dashboardReducer,
  notices: noticesReducer,
  versions: versionsReducer
});

var _default = (initialState = {}) => (0, _redux.createStore)(reducer, initialState);

exports.default = _default;