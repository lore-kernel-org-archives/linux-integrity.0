Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:43405 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753360AbdLUUi6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Dec 2017 15:38:58 -0500
Received: by mail-wr0-f174.google.com with SMTP id w68so13768017wrc.10
        for <linux-integrity@vger.kernel.org>; Thu, 21 Dec 2017 12:38:57 -0800 (PST)
Date: Thu, 21 Dec 2017 13:38:53 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Shaikh, Azhar" <azhar.shaikh@intel.com>
Cc: "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "javierm@redhat.com" <javierm@redhat.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tpmdd-devel@lists.sourceforge.net"
        <tpmdd-devel@lists.sourceforge.net>
Subject: Re: [PATCH] tpm: Fix the driver cleanup code
Message-ID: <20171221203853.GI20015@ziepe.ca>
References: <1513887422-123222-1-git-send-email-azhar.shaikh@intel.com>
 <20171221202652.GH20015@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF5828989144@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5FFFAD06ADE1CA4381B3F0F7C6AF5828989144@ORSMSX109.amr.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Dec 21, 2017 at 08:31:14PM +0000, Shaikh, Azhar wrote:

> Yes I thought about it too. But if some other chip->ops function in
> future, which *might* be in this same case, hence for that
> introduced this flag.

It can't be - the ops struct is constant, can't be modified, and
tpm_tis_core controls what is set. If someone future person meddles in
this then they can fix here to.

Recommend a short comment in the ops clk_enale initializer and call direct?

Jason
