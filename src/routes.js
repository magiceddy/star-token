import React from 'react';
import {Route, IndexRoute, Redirect} from "react-router";
import App from './App';

export const getRoutes = (web3Provided) => {
    return (
        <Route path="/" component={ () => (<App web3={web3Provided} />) }></Route>
    );
};