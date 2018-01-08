Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:39094 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754726AbeAHAFd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jan 2018 19:05:33 -0500
Date: Mon, 8 Jan 2018 11:04:58 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: [GIT PULL] linux-integrity patches for
 4.16-security-next-general
In-Reply-To: <1515159816.4418.7.camel@linux.vnet.ibm.com>
Message-ID: <alpine.LFD.2.20.1801081103570.8436@localhost>
References: <1515159816.4418.7.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 5 Jan 2018, Mimi Zohar wrote:

> The following changes since commit d21bd6898336a7892914d308d5e0868f0b863571:
> 
>   Sync to v4.15-rc3 for security subsystem developers to work against. (2017-12-11 17:01:08 +1100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
> 
> for you to fetch changes up to a2a2c3c8580a9158bca61221648fd6d5c98c443a:
> 
>   ima: Use i_version only when filesystem supports it (2017-12-18 09:43:49 -0500)
> 

Thanks, merged into:

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git 
	next-testing
	next-integrity



- James
-- 
James Morris
<james.l.morris@oracle.com>
