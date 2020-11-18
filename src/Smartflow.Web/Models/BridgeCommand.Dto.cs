﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Smartflow.Web.Models
{
    public class BridgeCommandDto
    {
        [Required]
        [StringLength(50)]
        public string CategoryCode
        {
            get;
            set;
        }

        [Required]
        [StringLength(50)]
        public string Key
        {
            get;
            set;
        }

        [StringLength(2048)]
        public string Comment
        {
            get; set;
        }

        [Required]
        [StringLength(50)]
        public string Creator
        {
            get;
            set;
        }
    }
}