Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46961 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750788AbeDLHPU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Apr 2018 03:15:20 -0400
Date: Thu, 12 Apr 2018 10:14:52 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Thiebaud Weksteen <tweek@google.com>
Cc: nayna@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tpm: Move eventlog declarations to its own header
Message-ID: <20180412071452.GD24124@linux.intel.com>
References: <20180411125501.188477-1-tweek@google.com>
 <20180411125501.188477-4-tweek@google.com>
 <20180412071230.GC24124@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180412071230.GC24124@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Apr 12, 2018 at 10:12:30AM +0300, Jarkko Sakkinen wrote:
> On Wed, Apr 11, 2018 at 02:55:01PM +0200, Thiebaud Weksteen wrote:
> > Reduce the size of tpm.h by moving eventlog declarations to a separate
> > header.
> > 
> > Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> 
> Will be fine with suggested-by added.

I don't see anything else to complain in subsequent patches.

Fix kbuild issue and add suggested-by tags and I can move on to
testing. Thanks!

/Jarkko
