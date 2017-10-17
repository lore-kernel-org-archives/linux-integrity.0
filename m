Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:56417
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1763071AbdJQP30 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 11:29:26 -0400
Date: Tue, 17 Oct 2017 17:29:20 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: Julia Lawall <julia.lawall@lip6.fr>,
        Alexander.Steffen@infineon.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        elfring@users.sourceforge.net, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
        clabbe.montjoie@gmail.com, jarkko.sakkinen@linux.intel.com,
        jgunthorpe@obsidianresearch.com, jsnitsel@redhat.com,
        kgold@linux.vnet.ibm.com, mpe@ellerman.id.au,
        nayna@linux.vnet.ibm.com, paulus@samba.org, PeterHuewe@gmx.de,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] char/tpm: Improve a size determination in nine
 functions
In-Reply-To: <1508253453.4234.81.camel@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1710171725080.5035@hadrien>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>         <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>         <1508238182.16112.475.camel@linux.intel.com>         <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>      
   <1508244757.4234.60.camel@linux.vnet.ibm.com>         <alpine.DEB.2.20.1710171456360.5035@hadrien> <1508253453.4234.81.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-103149562-1508254160=:5035"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On Tue, 17 Oct 2017, Mimi Zohar wrote:

> On Tue, 2017-10-17 at 14:58 +0200, Julia Lawall wrote:
> >
> > On Tue, 17 Oct 2017, Mimi Zohar wrote:
> >
> > > On Tue, 2017-10-17 at 11:50 +0000, Alexander.Steffen@infineon.com
> > > wrote:
> > > > > > Replace the specification of data structures by pointer dereferences
> > > > > > as the parameter for the operator "sizeof" to make the corresponding
> > > > > > size
> > > > > > determination a bit safer according to the Linux coding style
> > > > > > convention.
> > > > >
> > > > >
> > > > > This patch does one style in favor of the other.
> > > >
> > > > I actually prefer that style, so I'd welcome this change :)
> > >
> > > Style changes should be reviewed and documented, like any other code
> > > change, and added to Documentation/process/coding-style.rst or an
> > > equivalent file.
> >
> > Actually, it has been there for many years:
> >
> > 14) Allocating memory
> > ---------------------
> > ...
> > The preferred form for passing a size of a struct is the following:
> >
> > .. code-block:: c
> >
> > 	p = kmalloc(sizeof(*p), ...);
> >
> > The alternative form where struct name is spelled out hurts readability and
> > introduces an opportunity for a bug when the pointer variable type is changed
> > but the corresponding sizeof that is passed to a memory allocator is not.
>
> True, thanks for the reminder.  Is this common in new code?  Is there
> a script/ or some other automated way of catching this usage before
> patches are upstreamed?
>
> Just as you're doing here, the patch description should reference this
> in the patch description.

The comment in the documentation seems have been there since Linux 2.6.14,
ie 2005.  The fact that a lot of code still doesn't use that style, 12
years later, suggests that actually it is not preferred, or not preferred
by everyone.  Perhaps the paragraph in coding style should just be
dropped.

julia
From James.Bottomley@HansenPartnership.com Wed Oct 18 14:53:40 2017
Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: jarkko.sakkinen@linux.intel.com
Delivered-To: jarkko.sakkinen@linux.intel.com
Received: by jsakkine-mobl1 (fdm 1.7, account "linux.intel.com");
	Wed, 18 Oct 2017 14:53:40 +0300
Received: from fmsmga006.fm.intel.com (fmsmga006.fm.intel.com [10.253.24.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 745DE5801AD;
	Tue, 17 Oct 2017 08:57:18 -0700 (PDT)
Received: from orsmga102-1.jf.intel.com (HELO mga09.intel.com) ([10.7.208.27])
  by fmsmga006-1.fm.intel.com with ESMTP; 17 Oct 2017 08:57:18 -0700
X-SG-BADATTACHMENTNOREPLY: True
IronPort-PHdr: =?us-ascii?q?9a23=3As+N+ox9gAwNX4v9uRHKM819IXTAuvvDOBiVQ1KB+?=
 =?us-ascii?q?0+IRIJqq85mqBkHD//Il1AaPAd2DrasYwLuN+4nbGkU4qa6bt34DdJEeHzQksu?=
 =?us-ascii?q?4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPERvjKwV1?=
 =?us-ascii?q?Ov71GonPhMiryuy+4ZLebxlUiDanfL9/Ixq6oAHfu8ILnYZsN6E9xwfTrHBVYe?=
 =?us-ascii?q?pW32RoJVySnxb4+Mi9+YNo/jpTtfw86cNOSL32cKskQ7NWCjQmKH0169bwtRbf?=
 =?us-ascii?q?VwuP52ATXXsQnxFVHgXK9hD6XpP2sivnqupw3TSRMMPqQbwoXzmp8rxmQwH0hi?=
 =?us-ascii?q?gZKzE58XnXis1ug6JdvBKhvAF0z4rNbI2IKPZyYqbRcNUHTmRDQ8lRTTRMDICh?=
 =?us-ascii?q?YYUPEeQPM+RXr4fhqFUJohSwChKsBPvtxzJTmn/73rc33/g7HA3a3gEtGc8Fvn?=
 =?us-ascii?q?TOrNXyMacfSeS7w7PNzTrddPNdxCrw6I/UchA9pvGMWLZwftTRyEIyEA7Lik+f?=
 =?us-ascii?q?qYn7MDOOzOgArm+b7/Z8VeKojm4nrx9+ozi0y8kukIbJgJkVxU7C9Stj2ok1P8?=
 =?us-ascii?q?G4SEhlbt6+C5tQtyCaN5NsTsw+RGFovT83x7sbspC4ZCgH0IorywLbZvCdboSF?=
 =?us-ascii?q?7AzvWPyMLTp7mH5pYrOyihSq/UWg1uHwTMe53VZQoidEktTArG4B2wLO5sWBV/?=
 =?us-ascii?q?Bz5F2u2SyV2ADW8uxEIV47la7cK5M53L4wmYQcsV7ZEi/1hkr2lqmWeVsg+uSy?=
 =?us-ascii?q?7OTneLrmqoedN49ylA7+LrwjltKjDek8KAQCQmaW9fqm2LH+/kD1XK9Gg/w0n6?=
 =?us-ascii?q?XBtZDVP8Ubpqq3Aw9P1YYj7g6yDzOn0NQegHkGI0tJeBOBj4j1JV7OL+r4Dfaj?=
 =?us-ascii?q?g1WsiTtrwP7HPrv/DZXXNXXDjrjhcqhn60JGywo808pf55RKBbEFOv7zXVXxtN?=
 =?us-ascii?q?PAAh8jLwO02/rnCMl61o4GXGKPA6yZMKDVsVOS5uMvJ+iMZIkLtzb7MPUl4//u?=
 =?us-ascii?q?jXkkmV4SZ6Wp3J0XaGymEfRiOUmWfX3sgtIZG2cQogU+VPDqiEGFUTNLZXa9Rb?=
 =?us-ascii?q?g85jI4CIKhF4vDXZqigL+C3Ce6GJ1ZeGZGB0uIEXfpcYWERvgNZDiTIs9njjwL?=
 =?us-ascii?q?S7yhR5U92hGpsQ+pg4Zge9H6sggRr5H+z5BY4+PJlBc9vWh5C8qH0meCZ3xvk3?=
 =?us-ascii?q?kTASQxwbp0rEJ60FiOl651n6ocXfBa4btiWx0iOJjAwvYyX9z7XETKd82RRVC6?=
 =?us-ascii?q?T8+OBis4RdY8hdQJZhA5U9GjiA3TmiusH7Iajb2XFbQq/a/GmXv8PcBwzzDBzq?=
 =?us-ascii?q?Zlx10nRNZfLXWtw6Jy6SDXBpXViAOehaKjf79a2zTCp0mZym/bnkhdXRU4e6LZ?=
 =?us-ascii?q?QXcaYkbH5YDb70bPVPmEDqg7NQ5FxN+qCqJMcdDvtVxcWPHuIs/eYnr3kGC1U0?=
 =?us-ascii?q?XbjoiQZZbnLj1OlB7WD1IJxkVKpS6L?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DRAAAxJ+ZZh0O0hNFdHAEBBAEBCgEBF?=
 =?us-ascii?q?wEBBAEBCgEBhAh+J4N6ih+PN4F4EpYhgh6CAYgoPxgBAQEBAQEBAQEBARIBAQE?=
 =?us-ascii?q?IDQkIKC+COCQBgkEBAgMBAiAPAQ0BAREmAQUJAQEKGAICJgICA1QGAReKGAWpV?=
 =?us-ascii?q?2uCJ4MIAQEFiCsBAQgBAQEBARsIgQ+CH4E2UYFRhRWIGIJhkl6OcpZmiWuHMpV?=
 =?us-ascii?q?wgTcCH4IRVSWDQoJNgjJWin4BAQE?=
X-IPAS-Result: =?us-ascii?q?A0DRAAAxJ+ZZh0O0hNFdHAEBBAEBCgEBFwEBBAEBCgEBhAh?=
 =?us-ascii?q?+J4N6ih+PN4F4EpYhgh6CAYgoPxgBAQEBAQEBAQEBARIBAQEIDQkIKC+COCQBg?=
 =?us-ascii?q?kEBAgMBAiAPAQ0BAREmAQUJAQEKGAICJgICA1QGAReKGAWpV2uCJ4MIAQEFiCs?=
 =?us-ascii?q?BAQgBAQEBARsIgQ+CH4E2UYFRhRWIGIJhkl6OcpZmiWuHMpVwgTcCH4IRVSWDQ?=
 =?us-ascii?q?oJNgjJWin4BAQE?=
X-IronPort-AV: E=Sophos;i="5.43,391,1503385200"; 
   d="scan'208";a="486108914"
Received: from vger.kernel.org ([209.132.180.67])
  by mtab.intel.com with ESMTP; 17 Oct 2017 08:57:17 -0700
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934489AbdJQP5R (ORCPT <rfc822;mikko.ylinen@linux.intel.com>
        + 1 other); Tue, 17 Oct 2017 11:57:17 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52192 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934488AbdJQP5Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 11:57:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 95D138EE1C3;
        Tue, 17 Oct 2017 08:57:15 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vmoAAn-eMTH0; Tue, 17 Oct 2017 08:57:15 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BEBEF8EE0DF;
        Tue, 17 Oct 2017 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1508255835;
        bh=F5axQ3kbLQ+wdnQKBx0FeqAZ4d6HeZHzV2qzIaRshKI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tZoqBd+b1MppXmtVyRwJr7Tu/i+he4up77m6Vug3xwn5Uz+hztZlMb/7c0Rxw8sno
         COHZSSr6flfgwqNVlu14IQGER24x9/IzAWv2VP4BfxoVmHun+GizwW7fvXn9COUY3G
         cHdYlxWsjErrvwkuni6mWeGAe4omdqhf2N82Trnk=
Message-ID: <1508255833.3129.33.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/4] char-TPM: Adjustments for ten function
 implementations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     SF Markus Elfring <elfring@users.sourceforge.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Kenneth Goldman <kgold@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Date:   Tue, 17 Oct 2017 08:57:13 -0700
In-Reply-To: <f9b35a67-bd7f-b140-bdc1-cb4886a6b1ea@users.sourceforge.net>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
         <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
         <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
         <20171017085124.pkrjzghcf5wmcydc@mwanda>
         <f9b35a67-bd7f-b140-bdc1-cb4886a6b1ea@users.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2017-10-17 at 11:25 +0200, SF Markus Elfring wrote:
> > 
> > Fixes is only for bug fixes.  These don't fix any bugs.
> 
> How do you distinguish these in questionable source code
> from other error categories or software weaknesses?

A style change is one that doesn't change the effect of the execution.
 These don't actually even change the assembly, so there's programmatic
proof they're not fixing anything.

Bug means potentially user visible fault.  In any bug fix commit you
should document the fault and its effects on users so those backporting
can decide if they care or not.

James
