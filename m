Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:33475 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbdLJWMq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Dec 2017 17:12:46 -0500
Date: Mon, 11 Dec 2017 09:07:33 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH] ima: define a new policy option named "force"
In-Reply-To: <1512756740.3846.3.camel@linux.vnet.ibm.com>
Message-ID: <alpine.LFD.2.20.1712110907080.19397@localhost>
References: <1512756740.3846.3.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 8 Dec 2017, Mimi Zohar wrote:

> There are times instead of relying on previously cached status
> information we want to force the file to be re-measured, re-appraised,
> and re-audited.

Can you give an example of when this would be needed?

-- 
James Morris
<james.l.morris@oracle.com>
