Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:9264 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932089AbeARSlh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jan 2018 13:41:37 -0500
Date: Thu, 18 Jan 2018 20:41:34 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: [RFC][PATCH 1/3] tpm-chip: Move idr_replace calls to appropriate
 places
Message-ID: <20180118184134.qac6sewefbbvcxka@linux.intel.com>
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
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>

NAK

Not compatible with init_module().

http://man7.org/linux/man-pages/man2/init_module.2.html

/Jarkko
