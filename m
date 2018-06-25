Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:8687 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964861AbeFYSyT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Jun 2018 14:54:19 -0400
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v6] tpm: separate cmd_ready/go_idle from runtime_pm
Date: Mon, 25 Jun 2018 18:54:13 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9539B6@hasmsx108.ger.corp.intel.com>
References: <20180607212040.30989-1-tomas.winkler@intel.com>
         <20180618180406.GA20697@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9D94EA09@hasmsx108.ger.corp.intel.com>
         <20180621161958.GA11859@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9D9516CE@hasmsx108.ger.corp.intel.com>
 <7f90a0d8846650ce1e1d2598d980ab84da11cc70.camel@linux.intel.com>
In-Reply-To: <7f90a0d8846650ce1e1d2598d980ab84da11cc70.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


> 
> On Thu, 2018-06-21 at 18:40 +0000, Winkler, Tomas wrote:
> > I just wanted to make sure that 'RAW' not used in the api directly, it
> > will break the flow, do have any suggestion to make it obvious.
> 
> We will look at each code review as for any other peace of code how this flag
> is used and make decisions at that point what is legit use and what is not.

This is not about code review, there is a design decision to hide it, this is the API.
Please reconsider.
Thanks
Tomas
