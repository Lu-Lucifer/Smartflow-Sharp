﻿/********************************************************************
 License: https://github.com/chengderen/Smartflow/blob/master/LICENSE 
 Home page: http://www.smartflow-sharp.com
 Github : https://github.com/chengderen/Smartflow-Sharp
 ********************************************************************
 */
using Smartflow.Core.Components;
using Smartflow.Core.Elements;
using System;


namespace Smartflow.Core
{
    public class WorkflowContext
    {
        public WorkflowInstance Instance
        {
            get;
            set;
        }

        public string NodeID
        {
            get;
            set;
        }

        public string ActorID
        {
            get;
            set;
        }

        public string Message
        {
            get;
            set;
        }


        public dynamic Data
        {
            get;
            set;
        }

        public string TransitionID
        {
            get;
            set;
        }

        public Node Current
        {
            get;
            set;
        }

        private bool result = false;

        internal bool Result
        {
            get { return result; }
            set { result = value; }
        }
    }
}
