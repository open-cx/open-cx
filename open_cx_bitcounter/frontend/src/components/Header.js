import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import Button from '@material-ui/core/Button';
import IconButton from '@material-ui/core/IconButton';
import MenuIcon from '@material-ui/icons/Menu';
import Menu from '@material-ui/core/Menu';
import MenuItem from '@material-ui/core/MenuItem';

import PropTypes from 'prop-types';
import DialogTitle from '@material-ui/core/DialogTitle';
import Dialog from '@material-ui/core/Dialog';
import AddTalk from './AddTalkForm';
import AdminKey from './AdminKey';

const useStyles = makeStyles(theme => ({
  root: {
    flexGrow: 1,
  },
  menuButton: {
    marginRight: theme.spacing(2),
  },
  title: {
    flexGrow: 1,
  },
}));

export default function ButtonAppBar(props) {

  const classes = useStyles();

  const [anchorEl, setAnchorEl] = React.useState(null);
  const [open, setOpen] = React.useState(false);
  const [openAdmin, setOpenAdmin] = React.useState(false);
  
  const handleClick = event => {
    setAnchorEl(event.currentTarget);
  };

  const handleClickAdmin = () => {
    setOpenAdmin(true);
  };

  const handleClickPop = () => {
    setOpen(true);
    setAnchorEl(null);
  };

  const handleClose = () => {
    setAnchorEl(null);
    setOpen(false);
    setOpenAdmin(false);
  };

  return (
    <div className={classes.root}>
      <AppBar position="static">
        <Toolbar>
          <IconButton id="menu" edge="start" className={classes.menuButton} color="inherit" aria-label="menu" onClick={handleClick}>
            <MenuIcon aria-controls="main-menu" aria-haspopup="true" />
          </IconButton>
          <Menu
              id="main-menu"
              anchorEl={anchorEl}
              keepMounted
              open={Boolean(anchorEl)}
              onClose={handleClose}
            >
            <MenuItem onClick={handleClickPop} >Add talks</MenuItem>
          </Menu>
          <Typography variant="h6" className={classes.title}>
            News
          </Typography>
          <Typography variant="h6" className={classes.title}>
            BIT Counter
          </Typography>
          <Button color="inherit" aria-haspopup="true" onClick={handleClickAdmin}>Insert Admin Key</Button>
        </Toolbar>
      </AppBar>
      <SimpleDialog open={open} setOpen={setOpen} keyGetter={props.keyObject.keyGetter}/>
      <AdminDialog openAdmin={openAdmin} setOpenAdmin={setOpenAdmin} keyHandler={props.keyObject.keyHandler}/>
    </div>
  );
}

SimpleDialog.propTypes = {
  setOpen: PropTypes.func.isRequired
};

function SimpleDialog(props) {
  const { open, setOpen} = props;
  console.log(props.keyGetter);
  return (
    <Dialog
      aria-labelledby="simple-dialog"
      open={open}
    >
      <DialogTitle id="simple-dialog">
        <AddTalk setOpen={setOpen} keyGetter={props.keyGetter}/>
      </DialogTitle>
    </Dialog>
  );
}

AdminDialog.propTypes = {
  setOpenAdmin: PropTypes.func.isRequired
};

function AdminDialog(props) {
  const { openAdmin, setOpenAdmin, keyHandler } = props;

  return (
    <Dialog
      aria-labelledby="admin-dialog"
      open={openAdmin}
    >
      <DialogTitle id="admin-dialog">
        <AdminKey setOpenAdmin={setOpenAdmin} keyHandler={keyHandler}/>
      </DialogTitle>
    </Dialog>
  );
}


