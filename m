Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:10062 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754626AbdJQM6X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 08:58:23 -0400
Date: Tue, 17 Oct 2017 14:58:18 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: Alexander.Steffen@infineon.com, linux-kernel@vger.kernel.org,
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
In-Reply-To: <1508244757.4234.60.camel@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1710171456360.5035@hadrien>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>         <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>         <1508238182.16112.475.camel@linux.intel.com>         <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
 <1508244757.4234.60.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1030404471-1508245098=:5035"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On Tue, 17 Oct 2017, Mimi Zohar wrote:

> On Tue, 2017-10-17 at 11:50 +0000, Alexander.Steffen@infineon.com
> wrote:
> > > > Replace the specification of data structures by pointer dereferences
> > > > as the parameter for the operator "sizeof" to make the corresponding
> > > > size
> > > > determination a bit safer according to the Linux coding style
> > > > convention.
> > >
> > >
> > > This patch does one style in favor of the other.
> >
> > I actually prefer that style, so I'd welcome this change :)
>
> Style changes should be reviewed and documented, like any other code
> change, and added to Documentation/process/coding-style.rst or an
> equivalent file.

Actually, it has been there for many years:

14) Allocating memory
---------------------
...
The preferred form for passing a size of a struct is the following:

.. code-block:: c

	p = kmalloc(sizeof(*p), ...);

The alternative form where struct name is spelled out hurts readability and
introduces an opportunity for a bug when the pointer variable type is changed
but the corresponding sizeof that is passed to a memory allocator is not.

julia

>
> > > At the end it's Jarkko's call, though I would NAK this as I think some
> > > one already told this to you for some other similar patch(es).
> > >
> > >
> > > I even would suggest to stop doing this noisy stuff, which keeps people
> > > busy for nothing.
> >
> > Cleaning up old code is also worth something, even if does not
> > change one bit in the assembly output in the end...
>
> Wow, you're opening the door really wide for all sorts of trivial
> changes!  Hope you have the time and inclination to review and comment
> on all of them.  I certainly don't.
>
> There is a major difference between adding these sorts of checks to
> the tools in the scripts directory or even to the zero day bots that
> catch different sorts of errors, BEFORE code is upstreamed, and
> patches like these, after the fact.
>
> After the code has been upstreamed, it is a lot more difficult to
> justify changes like this.  It impacts both code that is being
> developed AND backporting bug fixes.
>
> Mimi
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
From andriy.shevchenko@linux.intel.com Wed Oct 18 14:47:17 2017
Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: jarkko.sakkinen@linux.intel.com
Delivered-To: jarkko.sakkinen@linux.intel.com
Received: by jsakkine-mobl1 (fdm 1.7, account "linux.intel.com");
	Wed, 18 Oct 2017 14:47:17 +0300
Received: from fmsmga006.fm.intel.com (fmsmga006.fm.intel.com [10.253.24.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C85605802B5;
	Tue, 17 Oct 2017 06:03:22 -0700 (PDT)
Received: from fmsmga103.fm.intel.com ([10.1.193.90])
  by fmsmga006-1.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2017 06:03:22 -0700
X-SG-BADATTACHMENTNOREPLY: True
IronPort-PHdr: =?us-ascii?q?9a23=3AFxcjhBIq3+O+RMqY0dmcpTZWNBhigK39O0sv0rFi?=
 =?us-ascii?q?tYgfI/vxwZ3uMQTl6Ol3ixeRBMOHs6oC0rad7vCocFdDyK7JiGoFfp1IWk1Nou?=
 =?us-ascii?q?QttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZr?=
 =?us-ascii?q?KeTpAI7SiNm82/yv95HJbAhEmCaxbalvIBi5ognctsobipZ+J6gszRfEvmFGcP?=
 =?us-ascii?q?lMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3QqBWAzogM2Au+c3krgLD?=
 =?us-ascii?q?QheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VSik4qx2UxLjlj?=
 =?us-ascii?q?sJOCAl/2HWksxwjbxUoBS9pxxk3oXYZJiZOOdicq/BeN8XQ3dKUMRMWCxbGo6y?=
 =?us-ascii?q?bJYBAeofM+hWrYb9qVwOoge5CwajC+3v0SdIi33t0K0m0eksCx3K0RY8E98Mtn?=
 =?us-ascii?q?nfsdX7NL0VUeCw1KTF0TPDYO5W2Dzg9YbIcg4uoe+QUrJwb8XRz0ovFwTYhViX?=
 =?us-ascii?q?s4PlOS6a1v4Ms2mb9eZgTuKvhHA5qw5tojig2MEsiorOho8OzlDE9CN5wJs6JN?=
 =?us-ascii?q?GiSU57Z8KkH4VUty2AK4R2RcYiTnhutS0nybMGoYa2cDYWxJkj3RLTdvKKf5aS?=
 =?us-ascii?q?7h7+V+udPS10iXNndb6nmhq//0etxvfhWsS631tGtDdJn9fNu3wXyhDf9tSLR/?=
 =?us-ascii?q?1g9Um7wzmPzRrc6uRcLEA0i6XbL5khz6Yulpocr0vDBDX6mEbog6+McEUr5Oyo?=
 =?us-ascii?q?5/7gYrX8qZ+QL450igfgPaQygsGzH/g0PwwUU2SG9+mwyqfv8VD6TblWlPE7k6?=
 =?us-ascii?q?vUvIjfJcsBp665BwFV0pwk6xa6Fzqm1NUYnX8aLFNKYR6Hjo7pO03QL/D3F/e/?=
 =?us-ascii?q?gkiskTdyy/DBMLzhBIvCLmLYnbf/crZy9VRcxBAwzd9B/ZJUDK8OIPbpVk/2rt?=
 =?us-ascii?q?zYAQc1MxaozOb/FNV9yoQeVHqKAq+YM6PSsliI6vgvIumIZY8VvijyK/4+6v7q?=
 =?us-ascii?q?jH85n0IdfKaz0ZsWbnC4AuppI0GDbXXwhdcBFH8AvhAiQ+zylF2CTTlTam6wX6?=
 =?us-ascii?q?0m/DE7C4GmDYDZSoC2mrOB3yS7HpxQZm9YDFCBCnPod4SCW/cRZyOeOM5hkjoY?=
 =?us-ascii?q?Vbe/T48tzw2htAj/y+kvEu2B3ywdtNrR09h8/aWHhxYy/CZcC8WbznHLUWd5gi?=
 =?us-ascii?q?UJTTpw16d69wg141OOwaF+j/FCU+dP6v1HXwESNJjSzup3DNa0UQXELfmTT1Pz?=
 =?us-ascii?q?a9OqEHkKTt8vyN8DZUV6U4GriBzZ3jvsGL8YibeLCZo39YrY3n7sN4B8zWrL0O?=
 =?us-ascii?q?8qiFxwEZgHDnGvmqMqr1ubPIXOiUjM0v/yLak=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BuAADH/uVZh0O0hNFdGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBBwEBAQEBFQEBAQECAQEBAQgBAQEBhQYng3qLE45DgXgSmCcuig9DFAEBAQE?=
 =?us-ascii?q?BAQEBAQEBEgEBAQgNCQgoL4I4JAGCQAEBAQECAQECID0ZBQEJAQEKGAICJgICA?=
 =?us-ascii?q?1QGARIFihAIBaoJgieLOQwmIm2CH4IHhmaIGIJhAQSSVY52lGuTGJcpNoF6eoN?=
 =?us-ascii?q?ChGJzAYp4AQEB?=
X-IPAS-Result: =?us-ascii?q?A0BuAADH/uVZh0O0hNFdGQEBAQEBAQEBAQEBBwEBAQEBFQE?=
 =?us-ascii?q?BAQECAQEBAQgBAQEBhQYng3qLE45DgXgSmCcuig9DFAEBAQEBAQEBAQEBEgEBA?=
 =?us-ascii?q?QgNCQgoL4I4JAGCQAEBAQECAQECID0ZBQEJAQEKGAICJgICA1QGARIFihAIBao?=
 =?us-ascii?q?JgieLOQwmIm2CH4IHhmaIGIJhAQSSVY52lGuTGJcpNoF6eoNChGJzAYp4AQEB?=
X-IronPort-AV: E=Sophos;i="5.43,391,1503385200"; 
   d="scan'208";a="246415019"
Received: from vger.kernel.org ([209.132.180.67])
  by mtab.intel.com with ESMTP; 17 Oct 2017 06:02:35 -0700
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758513AbdJQNCe (ORCPT <rfc822;mikko.ylinen@linux.intel.com>
        + 1 other); Tue, 17 Oct 2017 09:02:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:10158 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757690AbdJQNCe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 09:02:34 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP; 17 Oct 2017 06:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.43,390,1503385200"; 
   d="scan'208";a="910721424"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2017 06:02:06 -0700
Message-ID: <1508245325.16112.478.camel@linux.intel.com>
Subject: Re: [PATCH 3/4] char/tpm: Improve a size determination in nine
 functions
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Alexander.Steffen@infineon.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        elfring@users.sourceforge.net, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
        clabbe.montjoie@gmail.com, jarkko.sakkinen@linux.intel.com,
        jgunthorpe@obsidianresearch.com, jsnitsel@redhat.com,
        kgold@linux.vnet.ibm.com, mpe@ellerman.id.au,
        nayna@linux.vnet.ibm.com, paulus@samba.org, PeterHuewe@gmx.de,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Date:   Tue, 17 Oct 2017 16:02:05 +0300
In-Reply-To: <1508244757.4234.60.camel@linux.vnet.ibm.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
         <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
         <1508238182.16112.475.camel@linux.intel.com>
         <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
         <1508244757.4234.60.camel@linux.vnet.ibm.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.0-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2017-10-17 at 08:52 -0400, Mimi Zohar wrote:
> On Tue, 2017-10-17 at 11:50 +0000, Alexander.Steffen@infineon.com
> wrote:
> > > > Replace the specification of data structures by pointer
> > > > dereferences
> > > > as the parameter for the operator "sizeof" to make the
> > > > corresponding
> > > > size
> > > > determination a bit safer according to the Linux coding style
> > > > convention.
> > > 
> > > 
> > > This patch does one style in favor of the other.
> > 
> > I actually prefer that style, so I'd welcome this change :)
> 
> Style changes should be reviewed and documented, like any other code
> change, and added to Documentation/process/coding-style.rst or an
> equivalent file.

+1.

> > > At the end it's Jarkko's call, though I would NAK this as I think
> > > some
> > > one already told this to you for some other similar patch(es).
> > > 
> > > 
> > > I even would suggest to stop doing this noisy stuff, which keeps
> > > people
> > > busy for nothing.
> > 
> > Cleaning up old code is also worth something, even if does not
> > change one bit in the assembly output in the end...
> 
> Wow, you're opening the door really wide for all sorts of trivial
> changes!  Hope you have the time and inclination to review and comment
> on all of them.  I certainly don't.

Moreover and not so obvious is an open door for making back port of
*real* fixes much harder!

> There is a major difference between adding these sorts of checks to
> the tools in the scripts directory or even to the zero day bots that
> catch different sorts of errors, BEFORE code is upstreamed, and
> patches like these, after the fact.

+1.

> After the code has been upstreamed, it is a lot more difficult to
> justify changes like this.  It impacts both code that is being
> developed AND backporting bug fixes.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
