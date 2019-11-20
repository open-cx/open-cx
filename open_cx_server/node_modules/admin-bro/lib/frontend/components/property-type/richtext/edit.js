"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactDom = require("react-dom");

var _styledComponents = _interopRequireDefault(require("styled-components"));

var _ui = require("../../ui");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/* eslint-disable jsx-a11y/label-has-for */
const toolbarOptions = [[{
  header: [1, 2, 3, 4, 5, 6, false]
}], ['bold', 'italic', 'underline', 'strike'], // toggled buttons
['blockquote', 'code-block'], [{
  list: 'ordered'
}, {
  list: 'bullet'
}], [{
  script: 'sub'
}, {
  script: 'super'
}], // superscript/subscript
[{
  indent: '-1'
}, {
  indent: '+1'
}], // outdent/indent
[{
  direction: 'rtl'
}], // text direction
[{
  size: ['small', false, 'large', 'huge']
}], // custom dropdown
[{
  color: []
}, {
  background: []
}], // dropdown with defaults from theme
[{
  font: []
}], [{
  align: []
}], ['clean'] // remove formatting button
];

const Wrapper = _styledComponents.default.div.attrs({
  className: 'control has-icons-right'
}).withConfig({
  displayName: "edit__Wrapper",
  componentId: "sc-1ilg3d7-0"
})([".ql-toolbar{border-color:", ";.ql-picker{color:", ";}}.ql-container{border-color:", ";background:", ";}"], ({
  theme
}) => theme.colors.border, ({
  theme
}) => theme.colors.lightText, ({
  theme
}) => theme.colors.border, ({
  theme
}) => theme.colors.inputBck);

class Edit extends _react.default.Component {
  constructor(props) {
    super(props);
    this.wysiwigRef = _react.default.createRef();
  }

  componentDidMount() {
    this.setupWysiwig();
  }

  shouldComponentUpdate(nextProps) {
    const {
      record,
      property
    } = this.props;

    if (!nextProps) {
      return false;
    }

    const oldError = record.errors && record.errors[property.name] && record.errors[property.name].message;
    const newError = nextProps.record.errors && nextProps.record.errors[property.name] && nextProps.record.errors[property.name].message;
    return oldError !== newError;
  }

  componentDidUpdate() {
    this.setupWysiwig();
  }

  setupWysiwig() {
    const {
      property,
      record
    } = this.props;
    const value = record.params && record.params[property.name] || '';
    this.wysiwigRef.current.innerHTML = value;

    if (this.quill) {
      delete this.quill; // eslint-disable-next-line react/no-find-dom-node

      const thisNode = (0, _reactDom.findDOMNode)(this);
      const toolbars = thisNode.getElementsByClassName('ql-toolbar');

      for (let index = 0; index < toolbars.length; index += 1) {
        toolbars[index].remove();
      }
    }

    this.quill = new Quill(this.wysiwigRef.current, {
      modules: {
        toolbar: toolbarOptions
      },
      theme: 'snow'
    });
    this.quill.on('text-change', () => {
      this.handleChange(this.wysiwigRef.current.children[0].innerHTML);
    });
  }

  handleChange(value) {
    const {
      onChange,
      property
    } = this.props;
    onChange(property.name, value);
  }

  render() {
    const {
      property,
      record
    } = this.props;
    const error = record.errors && record.errors[property.name];
    return _react.default.createElement("div", {
      className: "field"
    }, _react.default.createElement(_ui.Label, {
      htmlFor: property.name
    }, property.label), _react.default.createElement(Wrapper, null, _react.default.createElement("div", {
      className: "quill-editor",
      ref: this.wysiwigRef,
      style: {
        height: '400px'
      }
    })), error && _react.default.createElement("div", {
      className: "help is-danger"
    }, error.message));
  }

}

exports.default = Edit;