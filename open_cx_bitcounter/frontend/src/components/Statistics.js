import React from 'react';
import { withStyles } from '@material-ui/core/styles';
import ExpansionPanel from '@material-ui/core/ExpansionPanel';
import ExpansionPanelDetails from '@material-ui/core/ExpansionPanelDetails';
import ExpansionPanelSummary from '@material-ui/core/ExpansionPanelSummary';
import Typography from '@material-ui/core/Typography';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';

const styles = theme => ({
  root: {
    width: '100%'
  },
  heading: {
    fontSize: theme.typography.pxToRem(15),
    flexBasis: '33.33%',
    flexShrink: 0
  },
  secondaryHeading: {
    fontSize: theme.typography.pxToRem(15),
    color: theme.palette.text.secondary
  }
});

class Statistics extends React.Component {
  state = {
    expanded: null
  };

  constructor(props) {
    super(props);

    this.max = 0;
    this.min = 0;
    this.average = 0;
    this.timeAtMax = "";

    this.state = {
      talkArray: this.props.talkArray
      }
    };

  handleChange = panel => (event, expanded) => {
    this.setState({
      expanded: expanded ? panel : false
    });
  };

  componentDidUpdate(prevProps) {
    if (prevProps === this.props)
      return;

    let max = -1;
    if(this.props.type === "talk") {

      this.expansionTitle = "Most Popular Talk of the Day";

      for (let i = 0; i < this.props.talkArray.length; i++) {
        let maxAux =  Math.max(...this.props.talkArray[i].occupation_list.map(s => s.value));
        if(maxAux >= max) {
          max = maxAux;
          this.max = maxAux
          this.room = this.props.talkArray[i].room;

          this.speaker = this.props.talkArray[i].speaker;
          this.min = Math.min(...this.props.talkArray[i].occupation_list.map(s => s.value));
          this.title = this.props.talkArray[i].title;
          
          let sum  = this.props.talkArray[i].occupation_list.map(item => item.value).reduce((prev, next) => prev + next);
          this.average = Math.ceil(sum / this.props.talkArray[i].occupation_list.length);

          let res = this.props.talkArray[i].occupation_list.filter(obj => obj.value === maxAux);
          let dateAux = res[0].date;
          this.timeAtMax = dateAux.split('T').join('.').split('.')[1];

          continue;
        }

        if(maxAux == -Infinity) {
          this.room = this.props.talkArray[i].room;
          this.speaker = this.props.talkArray[i].speaker;
          this.title = this.props.talkArray[i].title;
        }
      }

      return;
    }

    if (this.props.type === "all") {
      this.expansionTitle = "Most Popular Talk";
      
      let maxAux;
      for(let i = 0; i < this.props.daysArray.length; i++) {
        let talkArray = this.props.daysArray[i].talk;
      
        for(let j = 0; j < talkArray.length; j++) {
          maxAux =  Math.max(...talkArray[j].occupation_list.map(s => s.value));
          
          if(maxAux >= max) {
            max = maxAux;
            this.max = maxAux
            this.room = talkArray[j].room;

            this.speaker = talkArray[j].speaker;
            this.min = Math.min(...talkArray[j].occupation_list.map(s => s.value));
            this.title = talkArray[j].title;
            
            let sum  = talkArray[j].occupation_list.map(item => item.value).reduce((prev, next) => prev + next);
            this.average = Math.ceil(sum / talkArray[j].occupation_list.length);

            this.timeAtMax = this.props.daysArray[i].date;

            continue;
          }
        
          if(maxAux == -Infinity && max == -1) {
            this.room = talkArray[j].room;
            this.speaker = talkArray[j].speaker;
            this.title = talkArray[j].title;
            this.timeAtMax = this.
            props.daysArray[i].date;
          }
        }
      }
    }
  }

  render() {
    const { classes } = this.props;
    const { expanded } = this.state;

    return (

      <>
          <div className={classes.root}>
              <ExpansionPanel expanded={expanded === 'panel1'} onChange={this.handleChange('panel1')}>
                <ExpansionPanelSummary expandIcon={<ExpandMoreIcon/>}>
                  <Typography scope="row" style={{fontSize:'24px'}}><b>{this.expansionTitle}</b></Typography>
                </ExpansionPanelSummary>
                <ExpansionPanelDetails>

                  <div className="col-md-12" style={{ display: 'flex' }}>
                    <div className="col-md-6 float-left" style={{ alignSelf: 'center' }}>
                      <Typography align="left" style={{padding:'10px'}}><b>Title: </b>{this.title}</Typography>
                      <Typography align="left" style={{padding:'10px'}}><b>Speaker: </b>{this.speaker}</Typography>
                      <Typography align="left" style={{padding:'10px'}}><b>Room: </b>{this.room}</Typography>
                      <Typography align="left" style={{padding:'10px'}}><b>Max Atendees: </b>{this.max}</Typography>
                      <Typography align="left" style={{padding:'10px'}}><b>Min Atendees: </b>{this.min}</Typography>
                    </div>
                    <div className="col-md-6 float-right">
                        <Typography align="left" style={{padding:'10px'}}><b>Average Atendees: </b>{this.average}</Typography>
                        <Typography align="left" style={{padding:'10px'}}><b>Time @ Max Atendees: </b>{this.timeAtMax}</Typography>
                    </div>
                  </div>

                </ExpansionPanelDetails>
              </ExpansionPanel>
          </div>
      </>
    )
  }
}

export default withStyles(styles)(Statistics);