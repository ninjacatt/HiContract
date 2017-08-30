import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import Web3 from 'web3';
import _ from 'lodash';

const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

const abi = [{"constant":true,"inputs":[],"name":"listAllPerson","outputs":[{"name":"","type":"bytes32[]"},{"name":"","type":"uint256[]"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"people","outputs":[{"name":"name","type":"bytes32"},{"name":"age","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"name","type":"bytes32"},{"name":"age","type":"uint256"}],"name":"addPerson","outputs":[{"name":"addSucceed","type":"bool"}],"payable":false,"type":"function"}];
const address = '0x46dba1ba3bb117222e0adfd7e86620f91cea8532';
let names;
let ages;
class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      names: [],
      ages: []
    }
  }

  componentWillMount() {

    var coinbase = web3.eth.getCoinbase(function callback(err, result) {
      console.log(`coinbase address ${result}`);
    });
    const myContract = web3.eth.contract(abi);
    var contractInstance = myContract.at(address);
    let allPerson = contractInstance.listAllPerson();
    this.setState({
      names: String(allPerson[0]).split(','),
      ages:String(allPerson[1]).split(',')
    });
  }

  render() {
    let TableRows = [];
    _.each(this.state.names, (val, index) => {
      TableRows.push(
        <tr>
          <td>{web3.toAscii(this.state.names[index])}</td>
          <td>{this.state.ages[index]}</td>          
        </tr>
      );
    });
    return (
      <div className="App">
        <div className="App-header">
        </div>
        <div className="App-Content">
          <table>
            <thead>
              <tr>
                <th>name</th>
                <th>age</th>
              </tr>
            </thead>
            <tbody>
              {TableRows}
            </tbody>
          </table>
        </div>
      </div>
    );
  }
}

export default App;
