Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35875 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753743AbdLNT1J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Dec 2017 14:27:09 -0500
Received: by mail-wm0-f50.google.com with SMTP id b76so13609142wmg.1
        for <linux-integrity@vger.kernel.org>; Thu, 14 Dec 2017 11:27:09 -0800 (PST)
Date: Thu, 14 Dec 2017 12:27:05 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Subject: Re: [RFC][PATCH 1/3] tpm-chip: Move idr_replace calls to appropriate
 places
Message-ID: <20171214192705.GB20833@ziepe.ca>
References: <20171214160614.11808-1-Alexander.Steffen@infineon.com>
 <20171214160614.11808-2-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171214160614.11808-2-Alexander.Steffen@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Dec 14, 2017 at 05:06:12PM +0100, Alexander Steffen wrote:
> According to the comments, adding/removing the chip from the list should be
> the first/last action in (un)register. But currently it is done in a
> subfunction in the middle of the process. Moving the code from the
> subfunctions to the appropriate places within (un)register ensures that the
> code matches the comments.

The code is in the proper place.

The visibility of the IDR and the cdev are linked together, they
should be in the same place, side by side.

It doesn't make sense to dis-associate them in the code... If you have
a problem with comments they should be revised instead.

Jason
