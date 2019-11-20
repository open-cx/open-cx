"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

var _reactRedux = require("react-redux");

var _store = require("../../store/store");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const TIME_TO_DISAPPEAR = 3;

const NoticeWrapper = _styledComponents.default.div.attrs({
  className: 'notification'
}).withConfig({
  displayName: "notice__NoticeWrapper",
  componentId: "w4jhot-0"
})(["max-width:100%;position:absolute;top:0;left:0;right:0;border-radius:0;border-style:none none solid none;border-width:1px;padding:13px ", ";&:not(:last-child){margin-bottom:0;}&.success{background-color:", ";border-color:", ";& .progressBar{background-color:", ";}}&.error{background-color:", ";border-color:", ";& .delete:before,& .delete:after{background-color:", ";}& .progressBar{background-color:", ";}}& .delete{background:transparent;right:", ";top:", ";&:before,&:after{background-color:", ";}&:after{height:80%;width:1px;}&:before{width:80%;height:1px;}}& .progressBar{position:absolute;bottom:0;left:0;height:4px;background:#fff;transition:width 1s linear;}"], ({
  theme
}) => theme.sizes.paddingLayout, ({
  theme
}) => theme.colors.lightSuccess, ({
  theme
}) => theme.colors.success, ({
  theme
}) => theme.colors.success, ({
  theme
}) => theme.colors.lightError, ({
  theme
}) => theme.colors.error, ({
  theme
}) => theme.colors.error, ({
  theme
}) => theme.colors.error, ({
  theme
}) => theme.sizes.paddingLayout, ({
  theme
}) => theme.sizes.padding, ({
  theme
}) => theme.colors.success);

class NoticeElement extends _react.default.Component {
  constructor(props) {
    super(props);
    const {
      notice
    } = props;
    this.timer = null;
    this.state = {
      progress: notice.progress || 0
    };
  }

  componentDidMount() {
    const {
      drop,
      notice,
      notifyProgress
    } = this.props;
    this.timer = setInterval(() => {
      this.setState(state => {
        const progress = state.progress + 100 / TIME_TO_DISAPPEAR;
        notifyProgress({
          noticeId: notice.id,
          progress
        });
        return {
          progress
        };
      });
    }, 1000);
    setTimeout(() => {
      if (this.timer) {
        clearInterval(this.timer);
      }

      drop();
    }, 1000 * (TIME_TO_DISAPPEAR + 1));
  }

  componentWillUnmount() {
    if (this.timer) {
      clearInterval(this.timer);
    }
  }

  render() {
    const {
      notice,
      drop
    } = this.props;
    const {
      progress
    } = this.state;
    return _react.default.createElement(NoticeWrapper, {
      className: notice.type
    }, _react.default.createElement("button", {
      className: "delete",
      onClick: drop,
      type: "button"
    }), notice.message, _react.default.createElement("div", {
      className: "progressBar",
      style: {
        width: `${progress}%`
      }
    }));
  }

}

const NoticeBox = props => {
  const {
    drop,
    notices,
    notifyProgress
  } = props;
  const notice = notices.length ? notices[notices.length - 1] : null;

  if (notice) {
    return _react.default.createElement(NoticeElement, {
      key: notice.id,
      notice: notice,
      drop: () => drop(notice.id),
      notifyProgress: notifyProgress
    });
  }

  return _react.default.createElement("div", null);
};

const mapStateToProps = state => ({
  notices: state.notices
});

const mapDispatchToProps = dispatch => ({
  drop: noticeId => dispatch((0, _store.dropNotice)(noticeId)),
  notifyProgress: ({
    noticeId,
    progress
  }) => dispatch((0, _store.setNoticeProgress)({
    noticeId,
    progress
  }))
});

var _default = (0, _reactRedux.connect)(mapStateToProps, mapDispatchToProps)(NoticeBox);

exports.default = _default;