Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37699 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbeJJV3B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Oct 2018 17:29:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id d14-v6so5743326qto.4
        for <linux-integrity@vger.kernel.org>; Wed, 10 Oct 2018 07:06:41 -0700 (PDT)
Date: Wed, 10 Oct 2018 08:06:38 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: fix unused-value issues in tpm_try_transmit
Message-ID: <20181010140638.GA3894@ziepe.ca>
References: <20181010133817.GA11485@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181010133817.GA11485@embeddedor.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 10, 2018 at 03:38:17PM +0200, Gustavo A. R. Silva wrote:
> Currently, there are some values assigned to variable *rc*, which
> are never actually used in any computation, because such variable
> is updated at line 550, before they can be used:
> 
> 549out:
> 550        rc = tpm_go_idle(chip, flags);
> 551        if (rc)
> 552                goto out;
> 
> Fix this by removing such assignments. 

Should this be done by not quashing rc during the error unwind rather
than dropping the errors?

Jason
