Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:57528 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965788AbeF1Na4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jun 2018 09:30:56 -0400
Message-ID: <722fe86b2651d2616fa9bf43d9f8b1322f4c868b.camel@linux.intel.com>
Subject: Re: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alan Cox <alan@linux.intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Date: Thu, 28 Jun 2018 16:30:49 +0300
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D956753@hasmsx108.ger.corp.intel.com>
References: <20180624205202.6597-1-tomas.winkler@intel.com>
         <19b4282d625e04bb391f497419283a191bca610d.camel@linux.intel.com>
         <cb7ecb912486ee3e504de7c0918d667ebd370080.camel@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9D954923@hasmsx108.ger.corp.intel.com>
         <5c50d7fa2bf495f26443bd2da2e15df34c3d23f7.camel@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9D956753@hasmsx108.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-06-27 at 21:13 +0000, Winkler, Tomas wrote:
> Very well, I will remove the NESTED flag.  though I have feeling you are
> shooting from the hip you didn't really read the code. 
> Please there anyone who can review the code?

Asking to change a minor thing in a patch does not really fit into that
profile. I've even tried the patch a few times in it seems to work just
fine. You are making a big deal out of nothing.

/Jarkko
