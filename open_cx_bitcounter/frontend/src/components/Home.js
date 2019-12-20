import React, { Component } from 'react'
import Calendar from 'react-calendar';
import Box from '@material-ui/core/Box';

import axios from 'axios';

import Table from'./Table'
import Statistics from './Statistics'

export default class Home extends Component {


  constructor(props) {
    super(props);

    this.state = {
      daysArray: [],
      date: new Date(),
      keyGetter: this.props.keyGetter
    };

  }

  onChange = date => {
    this.setState({ date })
  }

  updateTalkList(){
    axios.get('http://api.feupbitcounter.info/api/room/list',{ crossdomain: true })
    .then((res) => {
      const { room } = res.data;
      let daysArray = [];
      for (let i = 0; i < room.length; i++) {
        let talkList = room[i].talk;
        for (let j = 0; j < talkList.length; j++) {
          const mTalk = talkList[j];
          const talkStartDate = new Date(mTalk.start);
          const talkEndDate = new Date(mTalk.end);
          const talkDate = talkStartDate.toDateString();

          let startTime = '';
          
          if(talkStartDate.getHours() < 10){
            startTime  += '0';
          }
          startTime  += talkStartDate.getHours().toString()

          startTime  += ':';
          if(talkStartDate.getMinutes() < 10){
            startTime  += '0';
          }
          startTime  +=  talkStartDate.getMinutes().toString() 
          
          startTime  += ' - '
          
          if(talkEndDate.getHours() < 10){
            startTime  += '0';
          }
          startTime += talkEndDate.getHours().toString() 
          
          startTime  += ':' 
          
          if(talkEndDate.getMinutes() < 10){
            startTime  += '0';
          }
          startTime += talkEndDate.getMinutes().toString() 
          mTalk.room = room[i].name
          mTalk.hour = startTime
          let newDate = true;
          for (let k = 0; k < daysArray.length; k++) {
            if (daysArray[k].date == talkDate) {
              daysArray[k].talk.push(mTalk)
              newDate = false;
            }
          }

          if (newDate && mTalk.start !== undefined) {
            const newDay = new Object({
              date: talkDate,
              talk: []
            })
            newDay.talk.push(mTalk)
            daysArray.push(newDay);
          }
        }
      }

      this.setState({daysArray: daysArray});
    }).catch(() => {
    });
  }

  componentDidMount() {
    this.updateTalkList();
    this.interval = setInterval(() => this.updateTalkList(), 5000);
  }

  render() {
    const { daysArray, date } = this.state;

    let talkArray = [];
    
    for (let i = 0; i < daysArray.length; i++) {
      if (daysArray[i].date == date.toDateString()) {
        talkArray = daysArray[i].talk;
        i = daysArray.length
      }
    }
    
    return (
      <>
      {daysArray.length != 0  ? (
        <Box boxShadow={10} className="statistics-container"> 
          <Statistics daysArray={daysArray} type="all"/>
        </Box>
      ): null }
        <Box boxShadow={10}>
          <Calendar
            onChange={this.onChange}
            value={this.state.date} />
        </Box>

        <Box boxShadow={10} className="rooms-container">
          <Table talkArray={talkArray} keyGetter={this.state.keyGetter}/>
        </Box>
        {talkArray.length != 0 ? (
          <Box boxShadow={10} className="statistics-container">
            <Statistics talkArray={talkArray} type="talk"/>
          </Box>
        ) : null}
      </>
    )
  }
}

