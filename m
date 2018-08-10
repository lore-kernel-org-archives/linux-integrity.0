Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58686 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbeHJVbz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Aug 2018 17:31:55 -0400
Message-ID: <1533927647.3143.7.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 2/2] tpm: add support for nonblocking operation
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 10 Aug 2018 12:00:47 -0700
In-Reply-To: <f49367fa-5af0-695e-342f-03a4bdcf35f2@intel.com>
References: <153367365951.18015.11320230309813817454.stgit@tstruk-mobl1.jf.intel.com>
         <153367366969.18015.14742040525393494830.stgit@tstruk-mobl1.jf.intel.com>
         <20180810174320.GV4692@linux.intel.com>
         <ad02d89f-31d3-7d9f-4580-daf759c8d837@intel.com>
         <1533926908.3143.6.camel@HansenPartnership.com>
         <f49367fa-5af0-695e-342f-03a4bdcf35f2@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-08-10 at 11:56 -0700, Tadeusz Struk wrote:
> On 08/10/2018 11:48 AM, James Bottomley wrote:
> > On Fri, 2018-08-10 at 11:21 -0700, Tadeusz Struk wrote:
> > > and the feedback I got from Jason was:
> > > 
> > > "I wonder if it is worth creating this when the first file is
> > > opened.. Lots of systems have TPMs but few use the userspace.."
> > > 
> > > so I changed this to allocate the WQ on first open. I think it
> > > makes sense, but I leave it to you to decide.
> > 
> > If the reason is to not create a wq unless it's needed, shouldn't
> > the condition actually be first open with flag O_NONBLOCK?
> > 
> 
> Not really because one can do:
> 
> int fd = open("/dev/tpm0", O_RDWR);
> fcntl(fd, F_SETFL, O_NONBLOCK);

so move the condition to first need to queue ...

James
