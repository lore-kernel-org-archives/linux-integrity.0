Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390726AbeIVBqD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Sep 2018 21:46:03 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LJsJxP003645
        for <linux-integrity@vger.kernel.org>; Fri, 21 Sep 2018 15:55:39 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mn6g61qdc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 21 Sep 2018 15:55:39 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 21 Sep 2018 20:55:37 +0100
Subject: Re: [PATCH] security/integrity: remove unnecessary 'init_keyring'
 variable
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Fri, 21 Sep 2018 15:55:33 -0400
In-Reply-To: <20180921193300.GB255965@gmail.com>
References: <20180907202515.217716-1-ebiggers@kernel.org>
         <1537555358.3830.345.camel@linux.ibm.com>
         <20180921185433.GA255965@gmail.com>
         <1537556534.3830.353.camel@linux.ibm.com>
         <20180921193300.GB255965@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1537559733.3830.363.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-09-21 at 12:33 -0700, Eric Biggers wrote:
> On Fri, Sep 21, 2018 at 03:02:14PM -0400, Mimi Zohar wrote:
> > On Fri, 2018-09-21 at 11:54 -0700, Eric Biggers wrote:
> > > On Fri, Sep 21, 2018 at 02:42:38PM -0400, Mimi Zohar wrote:
> > > > On Fri, 2018-09-07 at 13:25 -0700, Eric Biggers wrote:
> > > > > From: Eric Biggers <ebiggers@google.com>
> > > > > 
> > > > > The 'init_keyring' variable actually just gave the value of
> > > > > CONFIG_INTEGRITY_TRUSTED_KEYRING.  We should check the config option
> > > > > directly instead.  No change in behavior; this just simplifies the code.
> > > > 
> > > > We try to minimize as much as possible "ifdefs" in C code.  This
> > > > change is moving in the wrong direction.
> > > 
> > > So your preferred approach is to store the values of Kconfig options in
> > > variables?  That defeats much of the point of having Kconfig options...
> > 
> > No, I prefer using "ifdefs" in include files, not C code, and defining
> > stub functions.
> > 
> > Mimi
> > 
> 
> integrity_init_keyring() is already stubbed out in a header.  What are you
> suggesting, exactly?

Refer to section "20) Conditional Compilation" of
Documentation/process/coding-style.rst.

Mimi
