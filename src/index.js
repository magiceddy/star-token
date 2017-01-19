import React from 'react';
import ReactDOM from 'react-dom';
import Web3 from 'web3';
import { Provider } from "react-redux";
import { getStore } from './store';
import { getRoutes } from './routes';
import { Router, browserHistory } from "react-router";

import './index.css'

import truffleConfig from '../truffle.js';

var web3Location = `http://${truffleConfig.rpc.host}:${truffleConfig.rpc.port}`


window.addEventListener('load', function() {                    
  var web3Provided;
  // Supports Metamask and Mist, and other wallets that provide 'web3'.      
  if (typeof web3 !== 'undefined') {                            
    // Use the Mist/wallet provider.     
    // eslint-disable-next-line                       
    web3Provided = new Web3(web3.currentProvider);               
  } else {                                                      
    web3Provided = new Web3(new Web3.providers.HttpProvider(web3Location))
  }   

  const store = getStore();
  
  ReactDOM.render(
    <Provider store={store}>
      <Router history={browserHistory}>
        { getRoutes(web3Provided) }
      </Router>
    </Provider>,
    document.getElementById('root')
  )                                                                                                                    
});

