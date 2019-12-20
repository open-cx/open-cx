import React from 'react';
import TextField from '@material-ui/core/TextField';
import Dialog from '@material-ui/core/Dialog';
import DialogActions from '@material-ui/core/DialogActions';
import DialogContent from '@material-ui/core/DialogContent';
import DialogTitle from '@material-ui/core/DialogTitle';
import Button from '@material-ui/core/Button';
import axios from 'axios';

export default class AdminKey extends React.Component {
  constructor(props) {
    super(props);
    const { setOpenAdmin } = props;

    this.state = { key: '',
                    keyHandler: props.keyHandler,
                    openAdmin: false};

    this.handleKey = this.handleKey.bind(this);

    this.handleClose = () => {
      setOpenAdmin(false);
    };

    this.handleSubmit = event => {
      event.preventDefault();
      this.validateKey();
      this.handleClose();
    }
  }

  validateKey(){
    let params = {
      key: this.state.key
    }
  
    axios.post('http://127.0.0.1:6200/api/admin/validate', null, {params})
    .then((response) => {
      this.state.keyHandler(this.state.key); 
      console.log(response);
    })
    .catch(error => {
      console.log(error.message);
    });
  }

  handleKey(event) {
    this.setState({ key: event.target.value });
  }

  render() {
    return (
      <Dialog open={true} onClose={this.handleClose} aria-labelledby="form-diaglog-title">
        <DialogTitle id="form-dialog-title">
          Insert admin key
        </DialogTitle>
        <form onSubmit={this.handleSubmit}>
          <DialogContent>
            <TextField
              autoFocus
              margin="normal"
              required={true}
              id="Key" label="Key"
              value={this.key} onChange={this.handleKey}
              type="string" fullWidth
            />
            <DialogActions>
              <Button type="submit" label="submit" color="primary">
                Submit
              </Button>
            </DialogActions>
          </DialogContent>
        </form>
      </Dialog>
      );
  }
}