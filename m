Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:20439 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbdJWHke (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2017 03:40:34 -0400
Date: Mon, 23 Oct 2017 10:34:43 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Peter =?iso-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_core: Use common error handling code in
 tpm_tis_send_data()
Message-ID: <20171023073443.f34tqg5oevm7ijpo@mwanda>
References: <fb0a6fbb-db2f-ce3f-f1c2-02f934accc4e@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fb0a6fbb-db2f-ce3f-f1c2-02f934accc4e@users.sourceforge.net>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Markus, you should focus on fixing bugs.  The original code is fine.
These patches are a waste of reviewer time.

regards,
dan carpenter
