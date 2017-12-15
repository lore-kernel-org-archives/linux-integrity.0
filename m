Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp11.infineon.com ([217.10.52.105]:6462 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755438AbdLOJ0o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Dec 2017 04:26:44 -0500
From: <Alexander.Steffen@infineon.com>
To: <jgg@ziepe.ca>
CC: <jarkko.sakkinen@linux.intel.com>,
        <linux-integrity@vger.kernel.org>
Subject: RE: [RFC][PATCH 1/3] tpm-chip: Move idr_replace calls to appropriate
 places
Date: Fri, 15 Dec 2017 09:26:42 +0000
Message-ID: <68e838cda45d41109582bf0991bac056@infineon.com>
References: <20171214160614.11808-1-Alexander.Steffen@infineon.com>
 <20171214160614.11808-2-Alexander.Steffen@infineon.com>
 <20171214192705.GB20833@ziepe.ca>
In-Reply-To: <20171214192705.GB20833@ziepe.ca>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> On Thu, Dec 14, 2017 at 05:06:12PM +0100, Alexander Steffen wrote:
> > According to the comments, adding/removing the chip from the list should
> be
> > the first/last action in (un)register. But currently it is done in a
> > subfunction in the middle of the process. Moving the code from the
> > subfunctions to the appropriate places within (un)register ensures that the
> > code matches the comments.
> 
> The code is in the proper place.
> 
> The visibility of the IDR and the cdev are linked together, they
> should be in the same place, side by side.

Could you explain why that is? My understanding is that the cdev is for the user space to talk to the TPM, the IDR is for the kernel to talk to the TPM. They share the underlying device, but should otherwise be completely independent. You could (in theory) have the user space interface without the kernel interface or vice versa. What am I missing?

> It doesn't make sense to dis-associate them in the code... If you have
> a problem with comments they should be revised instead.
> 
> Jason
