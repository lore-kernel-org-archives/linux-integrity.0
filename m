Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:54125 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbeDLHMp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Apr 2018 03:12:45 -0400
Date: Thu, 12 Apr 2018 10:12:30 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Thiebaud Weksteen <tweek@google.com>
Cc: nayna@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tpm: Move eventlog declarations to its own header
Message-ID: <20180412071230.GC24124@linux.intel.com>
References: <20180411125501.188477-1-tweek@google.com>
 <20180411125501.188477-4-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180411125501.188477-4-tweek@google.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Apr 11, 2018 at 02:55:01PM +0200, Thiebaud Weksteen wrote:
> Reduce the size of tpm.h by moving eventlog declarations to a separate
> header.
> 
> Signed-off-by: Thiebaud Weksteen <tweek@google.com>

Will be fine with suggested-by added.

/Jarkko
